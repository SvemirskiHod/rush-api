require 'json'

# Possible Conditions on Query:
# Name filter
# offset -> for pagination
# sort Total Rushing Yards, Longest Rush and Total Rushing Touchdowns
class PlayersController < ApplicationController
  def index

    # Parse Players JSON file
    full_player_list = JSON.parse(File.read('app/rushing.json'));

    filtered_player_list = []

    # Extract Potential Parameter Values
    offset = params[:offset].to_i
    name_search = params[:name_search]
    sort_by = params[:sort_by]

    # If the offset is greater than the amount of players in the first place,
    # simply set it to 0
    if offset >= full_player_list.length
      offset = 0
    end

    # Perform Name Search
    if name_search
      full_player_list.each do |player|
        if player['Player'].downcase.include? name_search.downcase
          filtered_player_list.push(player)
        end
      end
    end

    #
    filtered_player_list = filtered_player_list[offset...offset + 25] || []

    # Return 25 Players, starting from the offset value
    return render :json => filtered_player_list
  end
end
