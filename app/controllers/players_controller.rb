require 'json'

# Possible Conditions on Query:
# Name filter
# offset for pagination
# Sorting for Total Rushing Yards, Longest Rush and Total Rushing Touchdowns
class PlayersController < ApplicationController
  def index

    # Parse Players JSON file
    full_player_list = JSON.parse(File.read('app/rushing.json'));

    filtered_player_list = full_player_list

    # Extract Potential Query String Values
    offset = params[:offset]
    name_search = params[:name_search]
    sort_by = params[:sort_by]

    # Perform Name Search
    if name_search
      full_player_list.each do |player|
        if player['Player'].downcase.include? name_search.downcase
          filtered_player_list.push(player)
        end
      end
    end

    if offset
      # Parse the offset into a usable integer
      offset = offset.to_i
      # If the offset is greater or equal to the amount of players in the first place,
      # simply set it to 0
      if offset >= full_player_list.length
        offset = 0
      end
      # Return 25 records, starting from the offset value
      filtered_player_list = filtered_player_list[offset...offset + 25] || []
    end

    return render :json => filtered_player_list
  end
end
