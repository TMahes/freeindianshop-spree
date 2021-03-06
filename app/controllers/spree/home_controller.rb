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

        def showoptiontypes
      @optiontypes = Spree::Taxon.where(:id=>params[:category])
      if @optiontypes.present?
        render :json =>  ["free-user", false , @optiontypes]
        else
        render :json =>  ["free-user", true , "No Option Types available on"]
      end
    end

    def showoptionvalues
      @optiontypes = Spree::OptionType.where(:name=>params[:type]).first
      @optionvalue = Spree::OptionValue.select("id,name").where(:option_type_id=>@optiontypes.id)
      if @optionvalue.present?
        render :json =>  ["free-user", params[:type] , @optionvalue]
        else
        render :json =>  ["free-user", true , "No Option Types available on"]
      end
    end

    def getoptionvalues
      @optiontypes = Spree::OptionType.where(:name=>params[:type]).first
      @optionvalue = Spree::OptionValue.where(:option_type_id=>@optiontypes.id)
      render :json => [@optionvalue]
    end
    def policies
     render :partial => "spree/shared/policies"
    end
    def refund
      render :partial => "/spree/shared/refund_policy"
    end
     def choosepost
      @product = Product.new
        logger.debug "choosen option types1 #{params[:option_types]}"
        optionTypes = params[:option_types].map(&:inspect).join(', ')
        params[:product].each do |product_params|
          @productTaxon = product_params["taxon_ids"]
        end
        redirect_to new_admin_product_path(:options=> params[:option_types], :taxons=> @productTaxon)
    end
      def optiontypecreate
         @optionvalue = Spree::OptionValue.find_by(name: params[:name].downcase)
        if @optionvalue.present?
           render :json =>  ["free-user", false , "Option Value already available"]
        else
            @optionvalue = OptionValue.new
            @optionvalue.position = 1
            @optionvalue.name = params[:name].downcase
            @optionvalue.presentation = params[:presentation]
            @optionvalue.option_type_id = params[:option_type]
            d = DateTime.now
            @optionvalue.created_at = d.strftime("%d/%m/%Y %H:%M")
            @optionvalue.updated_at = d.strftime("%d/%m/%Y %H:%M")
            @optionvalue.save
            render :json =>  ["free-user", true , "Option Value Added"]
        end
      end
    def choosesinglepost
        @product = Product.new
        logger.debug "choosen option types1 #{params[:option_types]}"
        optionTypes = params[:option_types].map(&:inspect).join(', ')
        params[:product].each do |product_params|
          @productTaxon = product_params["taxon_ids"]
      end
        @permalink = Spree::Taxon.find_by(:id=>@productTaxon)
          logger.debug "permalink #{@permalink.permalink}"
          if @permalink.permalink.include?("clothing")
            logger.debug "Clothing category redirect to multiple"
            redirect_to new_admin_product_path(:options=> params[:option_types], :taxons=> @productTaxon, :multiple=> 'yes')
        else
        redirect_to new_admin_product_path(:options=> params[:option_types], :taxons=> @productTaxon, :multiple=> 'yes')
      end
    end
  end
  
end
