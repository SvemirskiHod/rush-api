require 'json'

class PlayersController < ApplicationController
  def index
    full_list = JSON.parse(File.read('app/rushing.json'));
    render :json => full_list
  end
end
