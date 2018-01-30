Rails.application.routes.draw do
	devise_for :users, :controllers => {
		omniauth_callbacks: 'omniauth_callbacks',
		registrations: 'registrations'
	}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :opportunities
	get '/my_profile', to: 'profiles#my_profile'
	patch 'my_profile', to: 'profiles#update'
	patch 'my_profile/update_password', to: 'profiles#update_password'

	get '/auth', to: 'authorizations#landing'

	get 'tests/index'

	root 'tests#index'
end
