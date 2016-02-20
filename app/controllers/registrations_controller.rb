class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_to do |format|
          format.json { render json: { success: true, email: resource.email } }
          format.html { respond_with resource, location: after_sign_up_path_for(resource)}
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_to do |format|
          format.json { render json: current_user.errors, status: 422}
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource)}
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
          format.json { render json: { success: false, error_description: resource.errors.first.join(' ')}}
          format.html { respond_with resource}
        end
    end
    inital()
  end

  def inital
    file = File.read('lib/coin.json')
    json = JSON.parse(file)

      json['Continents'].each do |continent|
        continent.keys.to_s.delete! '["]'
        @continent = Continent.create(name: continent.keys)
        continent.values.each do |countries|
          countries.each do |country|
            country.keys.to_s.delete! '["]'
            @country = Country.create(name: country.keys)
            @continent.countries << @country
            country.values.each do |coins_sets|
              coins_sets.each do |coin_set|
                coin_set.keys.to_s.delete! '["]'
                @coin_set = CoinSet.create(years: coin_set.keys)
                @country.coin_sets << @coin_set 
                coin_set.values.each do |coins|
                  coins.each do |coin|
                  @coin = Coin.create(nominal: coin["nominal"], currency: coin["currency"])
                  @coin_set.coins << @coin
                  end
                end
              end
            end
          end
        end
      end
  end 



end
