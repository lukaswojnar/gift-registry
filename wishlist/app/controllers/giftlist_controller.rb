class GiftlistController < ApplicationController

  def index
    @wishlists = Giftlist.all
  end

  def new
    @wishlist = Giftlist.new
  end

  def show

  end


end
