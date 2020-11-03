Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Routes for assignment 4
  get '/assignments/harvey2', to: 'assignments#harvey2'
  get '/assignments/alan2', to: 'assignments#alan2'
  get '/assignments/alan3', to: 'assignments#alan3'
  # Routes for assignment 3 part 3
  get '/assignments/harvey', to: 'assignments#harvey'
  get '/assignments/alan', to: 'assignments#alan'
  get '/assignments/sean', to: 'assignments#sean'
  get '/assignments/sean2', to: 'assignments#sean2'
  get '/assignments/ian', to: 'assignments#ian'
  get '/assignments/jose', to: 'assignments#jose'
  
  # Gallery route
  get '/gallery', to: 'posts#gallery'
  # Routes for managing reporting broken links
  patch 'posts/broken/report/:id', to: 'posts#report' # Report a post as broken
  patch 'posts/broken/clear/:id', to: 'posts#clear' # Clear a post as not broken
  patch 'posts/broken/confirm/:id', to: 'posts#confirm' # Confirm a link as broken
  get 'posts/broken/reported', to: 'posts#reported' # Display reported links
  # Home route
  root 'posts#index'
end
