class RegistrationsController < Devise::RegistrationsController


def destroy
  PublicActivity::Activity.where(owner_type: "User",owner_id: current_user.id).each do |a|
    a.destroy
  end
    super
  end


def sign_up_params
  devise_parameter_sanitizer.sanitize(:sign_up)
end


def account_update_params
  devise_parameter_sanitizer.sanitize(:account_update)
end

private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :dob , :user_name,:bio)
  end

  def account_update_params
    params.require(:user).permit(:avatar_file_name, :avatar_content_type , :avatar_file_size, :avatar_updated_at, :avatar,:name, :email, :password, :password_confirmation, :current_password, :dob , :user_name,:bio,:deleted_at)
  end
end
