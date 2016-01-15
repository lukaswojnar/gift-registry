class GiftlistController < ApplicationController

  def index
    @giftlists = Giftlist.all
  end
end
