class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    current_user.active = false
    current_user.save
    # super
  end

  def update
    @user = User.find(current_user.id)

    if needs_password?
      super
    else
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
      account_update_params.delete('current_password')

      if @user.update_attributes(account_update_params)
        set_flash_message :notice, :updated
        sign_in @user, :bypass => true
        redirect_to edit_user_registration_path
      else
        render 'edit'
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dob , :user_name,:bio)
    # devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :dob , :user_name,:bio,:deleted_at)
    # devise_parameter_sanitizer.sanitize(:account_update)
  end

  def needs_password?
    params[:user][:current_password].present?
  end
end
