DeskApi::Application.routes.draw do
  get "home/index"
  root 'home#index'
  resources :desk_cases, only: [] do
    get 'fetch_desk_case' => 'home#fetch_desk_case', as: :fetch, on: :collection
  end

  post 'desk_labels', to: 'home#create_label', as: :create_label
  delete 'delete_label' => 'home#delete_label', as: :delete_label
  resources :desk_labels, only: [] do
    get 'fetch_desk_label' => 'home#fetch_desk_label', as: :fetch, on: :collection
    get 'find' => 'home#find_labels', as: :find, on: :member
    patch 'save_relation' => 'home#save_relation', as: :save, on: :collection
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
end
