Rails.application.routes.draw do
  get 'welcome/index'

  match "/plant/names/search/common/search", as: "plant_names_search_common_search", to: "plants/names/search/common#search", via: :get
  match "/plant/names/search/common", as: "plant_names_search_common", to: "plants/names/search/common#index", via: :get
  match "/plant/names/search/cultivar/search", as: "plant_names_search_cultivar_search", to: "plants/names/search/cultivar#search", via: :get
  match "/plant/names/search/cultivar", as: "plant_names_search_cultivar", to: "plants/names/search/cultivar#index", via: :get
  match "/plant/names/search/scientific/search", as: "plant_names_search_scientific_search", to: "plants/names/search/scientific#search", via: :get
  match "/plant/names/search/scientific", as: "plant_names_search_scientific", to: "plants/names/search/scientific#index", via: :get
  match "/plant/names/search/all/search", as: "plant_names_search_all_search", to: "plants/names/search/all#search", via: :get
  match "/plant/names/search/all", as: "plant_names_search_all", to: "plants/names/search/all#index", via: :get
  match "/plant/names/checklist", as: "plant_names_checklist", to: "plants/names/checklist#index", via: :get
  match "/plant/names/within/genus/search", as: "plant_names_within_genus_search", to: "plants/names/within/genus#search", via: :get
  match "/plant/names/within/genus", as: "plant_names_within_genus", to: "plants/names/within/genus#index", via: :get
  match "/plant/names/within", as: "plant_names_within", to: "plants/names/within#index", via: :get
  match "/plant/names/advanced", as: "plant_names_advanced", to: "plants/names/advanced#index", via: :get
  match "/plant/names/search/search", as: "plant_names_search_search", to: "plants/names/search#search", via: :get
  match "/plant/names/search", as: "plant_names_search", to: "plants/names/search#index", via: :get
  match "/plant/taxonomy/other", as: "plant_taxonomy_other", to: "plants/taxonomy/other#index", via: :get
  match "/plant/taxonomy/accepted/checklist", as: "plant_taxonomy_accepted_checklist", to: "plants/taxonomy/accepted/checklist#index", via: :get
  match "/plant/taxonomy/accepted/within", as: "plant_taxonomy_accepted_within", to: "plants/taxonomy/accepted/within#index", via: :get
  match "/plant/taxonomy/accepted/search", as: "plant_taxonomy_accepted_search", to: "plants/taxonomy/accepted/search#index", via: :get
  match "/plant/taxonomy/accepted", as: "plant_taxonomy_accepted", to: "plants/taxonomy/accepted#index", via: :get
  match "/plant/taxonomy", as: "plant_taxonomy", to: "plants/taxonomy#index", via: :get
  match "/plant/names", as: "plant_names", to: "plants/names#index", via: :get
  match "/plants", as: "plants", to: "plants#index", via: :get
  match "/mosses", as: "mosses", to: "mosses#index", via: :get
  match "/fungi", as: "fungi", to: "fungi#index", via: :get
  match "/lichens", as: "lichens", to: "lichens#index", via: :get
  match "/algae", as: "algae", to: "algae#index", via: :get
  match "/fauna", as: "fauna", to: "fauna#index", via: :get

  match "/apni/about", as: "about_apni", to: 'apni#about', via: :get
  match "/apni/index", as: "apni_index", to: 'apni#index', via: :get
  match "/apni/search", as: "apni_search", to: 'apni#search', via: :get
  match "/apni", as: "apni", to: 'apni#index', via: :get

  get 'apc/index'
  match "/apc", as: "apc", to: 'apc#index', via: :get

  get 'apni/search'

  get 'search/index'

  get 'search/apni'

  get 'search/apc'

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index', as: "welcome", via: :get

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route
  # (maps HTTP verbs to controller actions automatically):
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
