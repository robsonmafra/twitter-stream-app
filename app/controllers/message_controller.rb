class MessageController < ApplicationController

  def index
    @total, @twitts = Twitts.search_all(params['search'])
  end
end
