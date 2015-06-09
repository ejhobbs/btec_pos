Rails.application.routes.draw do
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

  root :to => 'home#index'

  get '/system/view' => 'system#view'
  get 'system/edit' => 'system#edit'
  get 'system/delete' => 'system#delete'
  get 'system/download' => 'system#download'
  get 'system/new' => 'system#new'
  post 'system/upload' => 'system#upload'
  post 'system/process_new' => 'system#process_new'
  post 'system/process_edit' => 'system#process_edit'
  post '/system/view' => 'system#view'

  get '/member/view' => 'member#view'
  get 'member/edit' => 'member#edit'
  get 'member/delete' => 'member#delete'
  get 'member/new' => 'member#new'
  get 'member/download' => 'member#download'
  post 'member/upload' => 'member#upload'
  post 'member/view' => 'member#view'
  post 'member/process_new' => 'member#process_new'
  post 'member/process_edit' => 'member#process_edit'

  get '/member_type/view' => 'member_type#view'
  get 'member_type/edit' => 'member_type#edit'
  get 'member_type/delete' => 'member_type#delete'
  get 'member_type/download' => 'member_type#download'
  get 'member_type/new' => 'member_type#new'
  post 'member_type/process_new' => 'member_type#process_new'
  post 'member_type/process_edit' => 'member_type#process_edit'
  post 'member_type/view' => 'member_type#view'
  post 'member_type/upload' => 'member_type#upload'

  get '/product/view' => 'product#view'
  get 'product/edit' => 'product#edit'
  get 'product/delete' => 'product#delete'
  get 'product/download' => 'product#download'
  get 'product/new' => 'product#new'
  post 'product/upload' => 'product#upload'
  post 'product/view' => 'product#view'
  post 'product/process_edit' => 'product#process_edit'
  post 'product/process_new' => 'product#process_new'

  get '/product_type/view' => 'product_type#view'
  get 'product_type/edit' => 'product_type#edit'
  get 'product_type/delete' => 'product_type#delete'
  get 'product_type/download' => 'product_type#download'
  get 'product_type/new' => 'product_type#new'
  post 'product_type/process_edit' => 'product_type#process_edit'
  post 'product_type/process_new' => 'product_type#process_new'
  post 'product_type/view' => 'product_type#view'
  post 'product_type/upload' => 'product_type#upload'

  get 'product_rental/new' => 'product_rental#new'
  get 'product_rental/edit' => 'product_rental#edit'
  get 'product_rental/view' => 'product_rental#view'
  get 'product_rental/view_receipt' => 'product_rental#view_receipt'
  get 'product_rental/delete' => 'product_rental#delete'
  get 'product_rental/return' => 'product_rental#return'
  get 'product_rental/overdue' => 'product_rental#view_overdue'
  get 'product_rental/add_items' => 'product_rental#add_items'
  get 'product_rental/view_detail' => 'product_rental#view_detail'
  post 'product_rental/add_items' => 'product_rental#add_items'
  post 'product_rental/process_edit' => 'product_rental#process_edit'
  post 'product_rental/view' => 'product_rental#view'
  post 'product_rental/process_new' => 'product_rental#process_new'

  get 'system_booking/new' => 'system_booking#new'
  get 'system_booking/edit' => 'system_booking#edit'
  get 'system_booking/view' => 'system_booking#view'
  get 'system_booking/delete' => 'system_booking#delete'
  post 'system_booking/view' => 'system_booking#view'
  post 'system_booking/process_new' => 'system_booking#process_new'
  post 'system_booking/process_edit' => 'system_booking#process_edit'
  get 'system_booking/view_receipt' => 'system_booking#view_receipt'
  get 'system_booking/due_today' => 'system_booking#due_today'

end
