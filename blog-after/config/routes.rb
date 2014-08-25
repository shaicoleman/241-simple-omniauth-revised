Blog::Application.routes.draw do
  resources :articles
  root to: 'articles#index'
  match 'auth/linkedin/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'logout', to: 'sessions#destroy', as: 'logout'
end
