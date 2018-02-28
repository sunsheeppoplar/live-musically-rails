Rails.application.routes.draw do
	devise_for :users, :controllers => {
		omniauth_callbacks: 'omniauth_callbacks',
		registrations: 'registrations'
	}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	resources :opportunities
	namespace :search do
		resources :opportunities
	end

	namespace :apply do
		resources :opportunities
	end

    get '/my_profile', to: 'profiles#my_profile'
    get '/my_profile/get_single_zipcode', to: 'profiles#get_single_zipcode'
	patch 'my_profile', to: 'profiles#update'
	patch 'my_profile/update_password', to: 'profiles#update_password'

	get '/auth', to: 'authentications#landing'

	get '/home', to: 'search/opportunities#new'
	root 'search/opportunities#new'
end
