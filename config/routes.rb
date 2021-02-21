Rails.application.routes.draw do
  root "pages#home"

  scope '/trades' do
    get '/new', to: 'trades#new'
    get '/:id', to: 'trades#show'
    post '/create', to: 'trades#create'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
