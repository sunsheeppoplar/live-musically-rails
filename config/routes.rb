Rails.application.routes.draw do
	devise_for :users, :controllers => {
		omniauth_callbacks: 'omniauth_callbacks',
		registrations: 'registrations'
	}
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get '/auth', to: 'authorizations#landing'

	get 'tests/index'

	root 'tests#index'
end
