Rails.application.routes.draw do
  root 'links#new'
  resources :links
  get ':in_url' => 'links#go'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
