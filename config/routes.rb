Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions passwords]
  namespace 'v1' do
    resources :customers
    resources :users
  end

  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
  end
end
