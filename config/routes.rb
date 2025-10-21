Rails.application.routes.draw do
  devise_for :users,
    path: "",
    defaults: { format: :json },
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

  # Swagger / Rswag
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
