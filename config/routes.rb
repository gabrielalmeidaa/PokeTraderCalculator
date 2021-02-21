Rails.application.routes.draw do
  root "trades#new"

  scope '/trades' do
    get '/new', to: 'trades#new'
    get '/historic', to: 'trades#historic'
    post '/create', to: 'trades#create'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
