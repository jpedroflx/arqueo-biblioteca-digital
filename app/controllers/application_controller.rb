# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate_user!, unless: :public_endpoint?

  # Só verifica Pundit onde interessa
  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?, if: :index_action?

  private

  # Rotas públicas (sem login)
  def public_endpoint?
    request.path.in?(['/signup', '/login']) || request.path.start_with?('/api-docs')
  end

  # Pular Pundit em Devise e controllers de auth + swagger
  def skip_pundit?
    devise_controller? ||
      controller_path.start_with?('users/sessions', 'users/registrations') ||
      request.path.start_with?('/api-docs')
  end

  # Este controller tem ação index?
  def index_action?
    self.class.action_methods.include?('index')
  end
end
