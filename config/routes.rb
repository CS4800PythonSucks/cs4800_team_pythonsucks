Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Routes for assignment 4
  get '/assignments/harvey2', to: 'assignments#harvey2'
  get '/assignments/alan2', to: 'assignments#alan2'
  # Routes for assignment 3 part 3
  get '/assignments/harvey', to: 'assignments#harvey'
  get '/assignments/alan', to: 'assignments#alan'
  get '/assignments/sean', to: 'assignments#sean'
  get '/assignments/sean2', to: 'assignments#sean2'
  get '/assignments/ian', to: 'assignments#ian'
  # Home route
  root 'posts#index'
end
