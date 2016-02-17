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
  end



end
