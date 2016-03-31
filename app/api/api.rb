require 'grape-swagger'

class API < Grape::API
        
  helpers do
    def warden
      env['warden']
    end
    
    def chek_authenticated
      unless authenticated
        error!("401 Unauthorized, 401")
        false
      end
      true
    end
    
    def authenticated
      return true if warden.authenticated?
      params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
    end

    def current_user
      warden.user || @user
    end
  end


  mount All
  
 

   add_swagger_documentation mount_path: "api"
end