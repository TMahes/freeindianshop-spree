module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products.order("spree_products.created_at DESC")
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
    def emailcheck
     @user = Spree.user_class.find_by(email:params[:email])
     logger.debug "mail id #{params[:email]}"
     logger.debug "mail id #{@user.present?}"
      if @user.present?
        render :json =>  ["free-user", false , "This User is already taken"]
        else
        render :json =>  ["free-user", true , "EmailId Available"]
      end
    end
    def checkshopname
     @shop = Spree.user_class.find_by(shop_name:params[:shopname])
     logger.debug "mail id #{params[:shopname]}"
     logger.debug "mail id #{@shop.present?}"
      if @shop.present?
        render :json =>  ["free-user", false , "This shop name is already taken"]
        else
        render :json =>  ["free-user", true , "Shop name Available"]
      end
    end
  end
end
