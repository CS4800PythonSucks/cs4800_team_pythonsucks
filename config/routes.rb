Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Routes for assignment 3 part 3
  get '/assignments/harvey', to: 'assignments#harvey'
  get '/assignments/alan', to: 'assignments#alan'
end
