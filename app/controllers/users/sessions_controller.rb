class Users::SessionsController < Devise::SessionsController
  # API: não usa CSRF, e responde JSON
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    # Quando login dá certo, Devise-JWT coloca o token no header Authorization automaticamente.
    render json: { message: "logged" }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end
