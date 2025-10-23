Rails.application.routes.draw do
  defaults format: :json do
    resources :authors
    resources :materials
  end

  # Devise (API): expõe só as rotas que usamos e mapeia para nossos controllers
  devise_for :users,
             skip: %i[sessions registrations passwords confirmations],
             defaults: { format: :json },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  devise_scope :user do
    # jwt.dispatch:  POST /login
    # jwt.revocation: DELETE /logout
    post   '/signup', to: 'users/registrations#create'
    post   '/login',  to: 'users/sessions#create'
    delete '/logout', to: 'users/sessions#destroy'
  end

  # Swagger / Rswag
  mount Rswag::Ui::Engine  => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
