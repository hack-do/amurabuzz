class SessionsController < Devise::SessionsController
	def create

  if (resource = resource_class.only_deleted.find_by_email(params[resource_name][:email]))    
    resource.restore!(:recursive => true)
    sign_in resource if resource.valid_password?(params[resource_name][:password])
  end
  super
end


end
