class All < Grape::API
  resource :api do

    resource :users do
      desc 'Add Coin for User'
      params do
        requires :coin_id, type: Integer
      end
      put do
        if chek_authenticated
          coin_id = params[:coin_id]
          if current_user.nil?
            error!({error_code: 404, error_message: "Invalid access token."},401)
            return
          end
          if coin_id > Coin.count || !(coin = Coin.find(coin_id))
            error!(status: false, error_message: "coin_id Invalid!")
          end
          current_user.coins.each do |c|
            if coin == c
              error!(status: false, error_message: "you already have such a coin")
              return
            end
          end
          current_user.coins << coin
          current_user.save!
        end
      end
      
      desc "List all Users"
      get do
        if chek_authenticated
          User.all
        end
      end

      desc "create a new User"
      params do
        requires :email, type: String
        requires :password, type:String
      end

      post do
        email = params[:email]
        password = params[:password]
        user =  User.new(email:email,password:password)
        unless user.valid?
          error!({success: false, error_description: user.errors.first.join(' ')})
          return
        end
        User.create!(email:email,password:password)
      end

      desc "delete an User"
      params do
        requires :access_token, type:String  
      end
      delete ':access_token' do
        user = User.where(authentication_token: params[:access_token]).first
        if user.nil?
          error!(status: false, error_message: "Invalid access token.")
          return
        else
          user.destroy
        end 
      end
    end

    resource :sessions do

      desc "Authenticate user and return user object / access token"

      params do
       requires :email, type: String, desc: "User email"
       requires :password, type: String, desc: "User Password"
      end

      post do
       email = params[:email]
       password = params[:password]

       if email.nil? or password.nil?
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       end

       user = User.where(email: email.downcase).first
       if user.nil?
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       end

       if !user.valid_password?(password)
         error!({error_code: 404, error_message: "Invalid Email or Password."},401)
         return
       else
         user.save
         {status: 'ok', token: user.authentication_token}
       end
      end

      desc "Destroy the access token"
      params do
       requires :access_token, type: String, desc: "User Access Token"
      end

      delete ':access_token' do
        access_token = params[:access_token]
        user = User.where(authentication_token: access_token).first
        if user.nil?
          error!({error_code: 404, error_message: "Invalid access token."},401)
          return
        else
          {status: 'ok'}
        end
      end
    end

    resource :continents do
      desc 'List all continents'
      get do
        if chek_authenticated
          Continent.all
        end
      end
    end

    resource :countries do
      
      desc 'List all countries of continent'
      params do
       requires :continent_name, type: String, desc: "Continent name"
      end

      get do
        if chek_authenticated
          continent = Continent.find_by name: params[:continent_name]
          if continent.nil?
          error!(status: false, error_message: "Invalid Continent Name.")
          return
          else
           continent.countries.all
          end
        end 
      end
    end

    resource :coin_sets do
      
      desc 'List all coin sets of country'
      params do
       requires :country_name, type: String, desc: "Country name"
      end

      get do
        if chek_authenticated
          country = Country.find_by name: params[:country_name]
          if country.nil?
          error!(status: false, error_message: "Invalid Country Name.")
          return
          else
           country.coin_sets.all
          end
        end 
      end
    end

    resource :coins do
      
      desc "List of the country's coin coin set"
      params do
       requires :country_name, type: String, desc: "Country name"
       requires :coin_set, type: String, desc: "Coin set"

      end

      get do
        if chek_authenticated
          country = Country.find_by name: params[:country_name]
          if country.nil?
            error!(status: false, error_message: "Invalid Country Name.")
            return
          end
          
          coin_set = country.coin_sets.find_by years: params[:coin_set]
          if coin_set.nil?
            error!(status: false, error_message: "Invalid Coin Set.")
            return
          else
            coin_set.coins
          end
        end
      end
    end

  end
end