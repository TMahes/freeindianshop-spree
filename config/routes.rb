Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  get 'admin/products/multinew'     => 'spree/admin/products#multinew', as: 'admin_products_multinew'
  get 'admin/products/choose'     => 'spree/admin/products#choose', as: 'admin_products_choose'
  mount Spree::Core::Engine, at: '/'

  #get "admin/products/multinew" => "products#multinew"
  #get 'admin/products/multinew', :to => 'products#multinew', :as => :multinew
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 post '/checkemail', to: 'spree/home#emailcheck'
 post '/checkshopname', to: 'spree/home#checkshopname'
 post '/showoptiontypes', to: 'spree/admin/products#showoptiontypes'
end