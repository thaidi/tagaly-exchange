Tagaly3::Application.routes.draw do
  get "forgotpassword/index"
  get "reports/index"
  get "payments/index"
  get "dashboard/index"
  get "units/index"
  get "publishers/index"
  get "publisher/index"
  get "preview/setdates"
  get "preview/graph"
  get "preview/editor"
  get "preview/styleoptions"
	get "preview/addplacement"
	get "preview/addstyles"
	get "preview/totalstats"
	get "preview/previewForAdDisplay"
  get "ads/updatestatus"
  get "publishers/introduction"
  get "users/introduction"
  get "ads/getminimumbidprice"
  get "ads/copyAd"
  get "ads/imagepreference"
  get "campaigns/addDisplayAds"
	get "campaigns/getAdPlacementsEdit"
	get "campaigns/uploadEdit"
	post "campaigns/uploadEdit"
	post "campaigns/:id/addNativeAds" => "campaigns#addNativeAds"

  resources :campaigns do
		collection do 
			match 'list', :via => [:get, :post]
			match 'check', :via => [:get, :post]
			match 'upload', :via => [:get, :post]
			match 'minBid', :via => [:get, :post]
			match 'adunits', :via => [:get, :post]
			match 'uploadad', :via => [:get, :post]
			match 'checkout', :via => [:get, :post]
			match 'saveAdunits', :via => [:get, :post]
			match 'updatestatus', :via => [:get, :post]
			match 'updatebudget', :via => [:get, :post]
			match 'startCampaign', :via => [:get, :post]
			match 'nativeadunits', :via => [:get, :post]
			match 'uploadcreatives', :via => [:get, :post]
			match 'uploadnativeads', :via => [:get, :post]
			match 'deleteplacements', :via => [:get, :post]
			match 'campaignsettings', :via => [:get, :post]
			match 'saveNativeAdunits', :via => [:get, :post]
			match 'checkCampaignName', :via => [:get, :post]
			match 'uploadNativeAdunitEdit', :via => [:get, :post]
			match 'getNativeAdPlacementsEdit', :via => [:get, :post]
		end
  end
  resources :conversions do
  collection do 
    match 'startConversion', :via => [:get, :post]
	match 'checklistnameavl', :via => [:get, :post]
	
    end
  end
  resources :forgotpassword
  post "forgotpassword/index"
  post "forgotpassword/new"
  resources :payments
  resources :reports
  resources :ads do
	collection do
		match 'startAd', :via => [:get, :post]
		match 'checkAdName', :via => [:get, :post]
		match 'uploadtempbanner', :via => [:get, :post]
	end
  end
  post "ads/new"
  resources :retargets do
   collection do 
    match 'checklistnameavl', :via => [:get, :post]
    match 'segment', :via => [:get, :post]
    match 'segmentgraph', :via => [:get, :post]
	match 'startRetarget', :via => [:get, :post]
  end
end
  resources :dashboard
  resources :sites do
  
  collection do 
    match 'tag', :via => [:get, :post]
    match 'trycode', :via => [:get, :post]
    match 'checkURL', :via => [:get, :post]
    match 'checkSiteName', :via => [:get, :post]
    match 'changestatus', :via => [:get, :post]
  end
end

resources :publishersites do
  collection do 
    match 'checkURL', :via => [:get, :post]
    match 'checkSiteName', :via => [:get, :post]
    match 'siteslist', :via => [:get, :post]
  end
end

 resources :units do
  collection do 
    match 'tag', :via => [:get, :post]
  end
end
 resources :fonts do
  collection do 
    match 'new', :via => [:get, :post]
  end
end

resources :styles do
  collection do 
    match 'new', :via => [:get, :post]
  end
end

resources :users do
  collection do 
    match 'checkEmail', :via => [:get, :post]
  end
end
	
  root to: "users#index"
   resources :users
	get "campaigns/addDisplayAds/frame" => "campaigns#addDisplayAds"
	get "logout" => "sessions#destroy", :as => "log_out"
	get "login" => "sessions#new", :as => "log_in"
	get "signup" => "users#new", :as => "sign_up"
	get "publishers" => "publishersites#index", :as => "publishers"
	get "publisher" => "publishersites#index", :as => "publisher"
	#get "publishers/dashboard" => "publishers#index", :as => "publishers/dashboard"
	get "publishers/dashboard/:siteId" => "publishers#index"
	get "mycampaign/:campaignId/:displayType" => "campaigns#index"
	get "mycampaign/:campaignId/:displayType/:graphType" => "campaigns#index"
	get "mycampaigns" => "campaigns#list"
	get "publishers/sites/:id" => "publishers#setsessions"
	get "ads/new/:frame" => "ads#new"
	get "styles/new/:frame/:adunitType" => "styles#new"
	get "retargets/new/:frame" => "retargets#new"
	get "conversions/new/:frame" => "conversions#new"
	
	get "advertiser/sites/:id" => "dashboard#setsessions"
  get "/resetpassword" => "forgotpassword#new", :as => "/resetpassword"
	resources :users
	resources :sessions
	resources :publishersites
	delete '/publishersites/:id(.:format)'=>"publishersites#destroy"
	delete '/retargets/:id(.:format)'=>"retargets#destroy"
	delete '/sites/:id(.:format)'=>"sites#destroy"
  delete '/adunits/:id(.:format)'=>"adunits#destroy"
  delete '/styles/:id(.:format)'=>"styles#destroy"
	get '/fonts/:id(.:format)/delete'=>"fonts#destroy"
  get "placements/creatingadunits" => "adunits#creatingadunits"
  post "placements/creatingadunits" => "adunits#creatingadunits"
  get "placements/startPlacement" => "adunits#startPlacement"
  get "placements/new" => "adunits#creatingadunits"
  post "placements/new" => "adunits#creatingadunits"
  get "placements/:id/edit" => "adunits#edit"
  post "placements/:id/edit" => "adunits#edit"
  get "placements" => "adunits#index"
  get "placements/getcode" => "adunits#getcode"
  get "placements/updateStatus/:id/:status" => "adunits#updateStatus"
  post "placements/updateStatus/:id/:status" => "adunits#updateStatus"
  post "preview/nativeStyleDisplay/:id" => "preview#nativeStyleDisplay"
  get "preview/nativeStyleDisplay/:id" => "preview#nativeStyleDisplay"
  get "preview/:id/jsonParseEdit"  => "preview#jsonParseEdit"
  post "preview/:id/jsonParseEdit"  => "preview#jsonParseEdit"
  get "placements/adApproval" => "adunits#adApproval"
  post "placements/adApproval" => "adunits#adApproval"
  get "preview/testUrl"
  get "preview/jsonParse"
  post "preview/jsonParse"
  get "adunits/creatingadunits"
  post "adunits/creatingadunits"
  get "adunits/createad"
  post "adunits/create"
  post "adunits/getcode"
  get "adunits/getcode"
  get "adunits/siteadunitslist"
  get "adunits/orderapproval"
  post "adunits/orderapproval"
  get "nativestyles/new"
  post "nativestyles/new"
  get "preview/getsitesbychannels"
  post "preview/getsitesbychannels"
  get "preview/getsitesbychannelsn"
  post "preview/getsitesbychannelsn"
  get "preview/getsitesbychannelsedit"
  post "preview/getsitesbychannelsedit"
  get "preview/getplacementsbysiteId"
  post "preview/getplacementsbysiteId"
  get "preview/getAllPlacementsBySiteId"
  post "preview/getAllPlacementsBySiteId"
  get "campaigns/adunits/:frame" => "campaigns#adunits"
  post "campaigns/adunits/:frame" => "campaigns#adunits"
  post "campaigns/:id/saveRunOfNetworkData" => "campaigns#saveRunOfNetworkData"
  post "campaigns/:id/saveAdPlacementData" => "campaigns#saveAdPlacementData"
	post "campaigns/:id/saveNativeAdPlacementData" => "campaigns#saveNativeAdPlacementData"

  resources :adunits do
  collection do 
    match 'adunits', :via => [:get, :post]
  end
end
resources :adunits do
  collection do 
    match 'getcode', :via => [:get, :post]
  end
end
resources :preview do
  collection do 
    match 'index', :via => [:get, :post]
  end
end
get "ads/frame"
get "reports/publisher/:id", to: "reports#index"
get "reports/publisher/:id/:exportType", to: "reports#index"
get "publishergraph/:id/:graphType", to: "preview#publishergraph"
get "channels/:type", to: "adunits#newplacement"
post "channels/:type", to: "adunits#newplacement"
get "channels/:type/:placementId", to: "adunits#newplacement"
delete "channels/:type/:placementId(.:format)", to: "adunits#newplacement"
post "channels/:type/:placementId", to: "adunits#newplacement"
post ':controller(/:id(/:action))'
get ':controller(/:id(/:action))'
get "publishersites/changestatus/:id/:option", to: "publishersites#changestatus"




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
