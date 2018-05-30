Rails.application.routes.draw do
  resources :images
  # for registrations look at my controllers and registrations first and then
  # go to devise registrations controller
  devise_for :users, :controllers => { :registrations => 'registrations' }
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
