class ApplicationController < ActionController::API
  before_action :authenticate_user!, unless: :public_endpoint?

  private
  def public_endpoint?
    request.path.in?(['/signup', '/login']) || request.path.start_with?('/api-docs')
  end
end
