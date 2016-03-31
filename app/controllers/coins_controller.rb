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
        flash[:success] = "The coin has been successfully added"
    else
        flash[:warning] = "you already have such a coin" 
    end
  end

  # def continents
  #   respond_to do |format|
  #     format.json { continents_map}
  #   end
  # end

  # def countries
  #   continent = Continent.find_by name: params[:name]
  #   if check_params(continent)
  #     respond_to do |format|
  #       format.json { countries_map(continent) }
  #     end
  #   end
  # end
  
  # def coin_sets
  #   country = Country.find_by name: params[:country_name]
  #   if check_params(country)
  #     respond_to do |format|
  #       format.json { coin_sets_map(country) }
  #     end
  #   end
  # end
  
  # def coins
  #   country = Country.find_by name: params[:country_name]
  #   unless check_params(country)
  #     return
  #   end
  #   coin_set = country.coin_sets.find_by years: params[:years]
    
  #   if check_params(coin_set)
  #     respond_to do |format|
  #       format.json { coins_map(coin_set) }
  #     end
  #   end
  # end
  
  # def coins_search
  #   @country = Country.find_by name: params[:param]
  # end

  # private

  # def continents_map
  #   render json: {  success: true, 
  #                   continents: Continent.all.map{|c| { id: c.id, name: c.name}}}
  # end

  # def countries_map(continent)
  #   render  json: { success: true, 
  #                   continent_id: continent.id, 
  #                   countries: continent.countries.map{|c| {id: c.id, name: c.name}}}
  # end

  # def coin_sets_map(country)
  #   render json: {success: true, 
  #                 country_id: country.id, 
  #                 coin_sets: country.coin_sets.map { |c| { id: c.id, years: c.years}}}
  # end

  # def coins_map(coin_set)
  #   render json: {success: true, 
  #                 coin_set_id: coin_set.id, 
  #                 coins: coin_set.coins.map {|c| {id: c.id, 
  #                                                 nominal: c.nominal, 
  #                                                 currency: c.currency}}}
  # end

  # def check_params param
  #   unless param
  #     false_params
  #     false
  #     return
  #   end
  #   true   
  # end

  # def false_params
  #   respond_to do |format|
  #     format.json { render json: { success: false, error_description: "Invalid params!"} }
  #   end
  # end

end