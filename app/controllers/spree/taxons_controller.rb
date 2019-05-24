module Spree
  class TaxonsController < Spree::StoreController
    helper 'spree/products'

    respond_to :html

    def show

      logger.debug "=================== from spree"
      @taxon = Taxon.friendly.find(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @productsf = @searcher.retrieve_products
      if params[:mii] == 'yes'
          @productsf = @searcher.retrieve_products
          @products = @products.sort_by { |products| products.promotionable? ? 0:1}
        elsif params[:ni] == 'yes'
          @productsf = @searcher.retrieve_products
          @products = @products.sort_by { |products| products.promotionable? ? 1:0}
        elsif params[:zip]
          geo=Geokit::Geocoders::GoogleGeocoder.geocode(params[:zip])
          distance = Spree::Distance.within(5000, :origin => geo) 
          logger.debug "======++++======#{distance.pluck("zipcode")}"
          zip =  distance.pluck("zipcode")
          @sellers = Spree.user_class.where(:zip_code => zip)   
          logger.debug "====================supplier ID=================#{@sellers.pluck("supplier_id").compact}"
          @products2 = @searcher.retrieve_products
          seller_id = @sellers.pluck('supplier_id').compact
         
           @products = @products2.where(:vendor_id => seller_id)
           @products = @products.sort_by { |products| products.promotionable? ? 0:1}
           logger.debug "=====================Product ID================#{@products.pluck("id").compact}"
           
        else
          @products = @searcher.retrieve_products
      end
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

    private

    def accurate_title
      @taxon.try(:seo_title) || super
    end
  end
end
