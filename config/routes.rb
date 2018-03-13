Rails.application.routes.draw do
	devise_for :users, :controllers => {
		omniauth_callbacks: 'omniauth_callbacks',
		registrations: 'registrations'
	}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	mount ActionCable.server => '/cable'

	get '/conversations/load_conversation', to: 'conversations#load_conversation', as: "load_conversation", defaults: { format: 'json' }
	get '/conversations/load_new_message', to: 'conversations#load_new_message', as: "load_new_message", defaults: { format: 'json' }

	resources :conversations do
		resources :messages
	end

	# get '/conversations', to: 'conversations#index'

	resources :opportunities
	get '/my_profile', to: 'profiles#my_profile'
	get '/my_profile/get_single_zipcode', to: 'profiles#get_single_zipcode'
	patch 'my_profile', to: 'profiles#update'
	patch 'my_profile/update_password', to: 'profiles#update_password'

	get '/auth', to: 'authentications#landing'

	get 'tests/index'

	root 'tests#index'
end
