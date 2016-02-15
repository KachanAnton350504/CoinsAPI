class CoinsController < ApplicationController
  def index
    @coins = Coin.all
    @continent = Continent.all
  end
  
  
  def show
    @coins = Coin.all
    @continents = Continent.all
  end

  def coin_information
    @coin = Coin.find(params[:coin_id])
  end
  
  def coin_add
    @coin = Coin.find(params[:coin_id])
    if !current_user.coins.include?(@coin)
        current_user.coins << @coin
        flash[:notice] = "The coin has been successfully added"
    else
        flash[:notice] = "you already have such a coin" 
    end
  end
 
end
