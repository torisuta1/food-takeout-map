class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      added_attrs = [:username, :agreement]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    end
end
