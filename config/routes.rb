Rails.application.routes.draw do
	devise_for :users, :controllers => {
		omniauth_callbacks: 'omniauth_callbacks',
		registrations: 'registrations'
	}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	mount ActionCable.server => '/cable'

	get '/conversations/load_conversation', to: 'conversations#load_conversation', as: "load_conversation", defaults: { format: 'json' }
	get '/conversations/load_new_message', to: 'conversations#load_new_message', as: "load_new_message", defaults: { format: 'json' }
	get '/conversations/send_message', to: 'messages#ajax_create', as: "send_message", defaults: { format: 'json' }

	resources :conversations do
		resources :messages
	end

	# get '/conversations', to: 'conversations#index'

	resources :opportunities
	
	resources :opportunities do
		resources :submissions
	end

	resource :onboard, only: [:show, :create]

	namespace :search do
		resources :opportunities
	end

	namespace :apply do
		resources :opportunities
	end

	get '/policies/terms', to: 'policies#terms_of_service'
	get '/policies/privacy', to: 'policies#private_policy'

    get '/my_profile', to: 'profiles#my_profile'
    get '/my_profile/get_single_zipcode', to: 'profiles#get_single_zipcode'
	patch 'my_profile', to: 'profiles#update'
	patch 'my_profile/update_password', to: 'profiles#update_password'

	get '/auth', to: 'authentications#landing'

	get '/home', to: 'search/opportunities#new'
	root 'search/opportunities#new'
end
