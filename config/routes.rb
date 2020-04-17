Rails.application.routes.draw do
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score', as: :score
  root to: 'games#home'
  # get 'result', to: 'games#result', as: :result
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

