Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'

  #get "admin/products/multinew" => "products#multinew"
  #get 'admin/products/multinew', :to => 'products#multinew', :as => :multinew
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 post '/checkemail', to: 'spree/home#emailcheck'
 post '/checkshopname', to: 'spree/home#checkshopname'
 post '/showoptiontypes', to: 'spree/admin/products#showoptiontypes'
 post '/showoptionvalues', to: 'spree/admin/products#showoptionvalues'

 Spree::Core::Engine.add_routes do
  post 'admin/products/choosepost'     => 'admin/products#choosepost'
  get 'admin/products/multinew'     => 'admin/products#multinew', as: 'admin_products_multinew'
  get 'admin/products/choose'     => 'admin/products#choose'
end
end