FasterNotes::Application.routes.draw do

  devise_for :users, controllers: {sessions: "sessions"}, :skip => [:sessions]
  as :user do
    get 'signin' => 'welcome#login', :as => :new_user_session
    get 'reset_password' => 'welcome#reset_password', :as => :reset_password
    #post 'reset' => 'welcome#forgot_password', :as => :forgot_password
    post 'fn_signin' => 'sessions#create', :as => :fn_user_session
    get 'logout_fn_user' => 'sessions#logout_fn_user', :as => :logout_fn_user #Logout path for clearing already login user before login other user.
    post 'signin' => 'sessions#create', :as => :user_session
    match 'signout' => 'sessions#destroy', :as => :destroy_user_session,
          :via => :get
  end

  match '/mobile/authenticate', :to => 'mobile#authenticate'
  match '/mobile/version', :to => 'mobile#data_version'
  match '/mobile/patients', :to => 'mobile#patients'
  match '/mobile/sync', :to => 'mobile#sync'

  get "users/sign_in", :to => "welcome#login"
  get "welcome/index"
  get "welcome/login"
  get "welcome/report"
  get "welcome/switching_tabs"
  match 'welcome/assign_supervised_user/:id' => 'welcome#assign_supervised_user', via: :post
  match 'active'  => 'welcome#active',  via: :get
  match 'timeout' => 'welcome#timeout', via: :get
  match 'may_be_logging_out' => 'welcome#may_be_logging_out', via: :get

  match '/:component', :to => "welcome#component"

  match 'reports/worksheet/:patient_id' => 'reports#generate_case_worksheet', :as => "work_sheet"
  match 'reports/invoice/:invoice_id' => 'reports#pre_generated', :as => "invoice"
  match 'reports/eligibility' => 'reports#pre_generated', :as => "eligibility"
  match 'reports/medication_list/:treatment_id/:date' => 'reports#generate_medication_list', :as => "medication_list"
  match 'reports/pre_generated' => 'reports#pre_generated', :as => "pre_generated"
  match 'reports/generated/:file_name' => 'reports#generated', :as => "generated"
  match 'reports/:document_id' => 'reports#generate', :as => "reports"
  match 'oasis_export/:reference' => 'oasis_export_download#download', :as => "oasis_export"
  match 'claim/:reference' => 'downloads#download_zip_file', :as => "export_claims_zip_file"
  match 'edi_claims/:reference' => 'downloads#download_file', :as => "export_claims_file"
  match 'claim_edis/:id' => 'downloads#download_transmission_log_file', :as => "transmission_log_file"
  match 'cahps_export/:reference' => 'cahps_export_download#download', :as => "cahps_export"
  match 'oasis/hipps_code_generation' => 'oasis#get_hipps_code_and_amount'
  match 'orders/:reference' => 'downloads#download_zip_file', :as => "export_orders_zip_file"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  netzke
  match 'components/:component' => 'components#index', :as => "components"

  root :to => "welcome#index"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
