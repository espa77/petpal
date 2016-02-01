Rails.application.routes.draw do

  root to: 'home#front'
  get 'posts/:id/destroy', to: 'posts#destroy'
  # post 'users/:id/profile_page', to: 'users#upload'

  get 'friendships/:id/destroy', to: 'friendships#destroy', :as => :unfriend
  #creating this route was necessary for getting the correct commentable id
  #along with the id of the comment. There is likely a better way.
  get 'posts/:post_id/comment/:id/like', to: 'comments#like', :as => :like_comment
  get 'posts/:post_id/comment/:id/unlike', to: 'comments#unlike', :as => :unlike_comment


  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session_path
    post 'login' => 'devise/sessions#create', :as => :user_session_path
    get 'users/sign_out', to: 'devise/sessions#destroy'
    get 'users/index', to: 'users#index'
    get 'users/:id/profile_page', to: 'users#show', :as => :profile_page
  end

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: "users/omniauth_callbacks" }

  resources :posts do
    member do
      get 'like'
      get 'unlike'
    end
  end

  resources :favorites do
    member do
      get 'like'
      get 'unlike'
    end
  end

  resources :uploads
  resources :comments, only: [:create, :destroy]
  resources :favorites
  resources :friendships, except: [:destroy]
  # devise_for :users

  # devise_for :users, path: "", controllers: { sessions: "sessions", registrations: "registrations" }, path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unlock: 'unblock', sign_up: 'register', sign_out: 'signout'}

end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
