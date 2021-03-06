module Spree
  module Admin
    class ProductsController < ResourceController
      helper 'spree/products'

      before_action :load_data, except: :index
      create.before :create_before
      update.before :update_before
      helper_method :clone_object_url

      def show
        session[:return_to] ||= request.referer
        redirect_to action: :edit
      end

      def index
        session[:return_to] = request.url
        respond_with(@collection)
      end

      def multinew
       @product = Product.new
    end
    def choose
      @product = Product.new
    end

def create
  logger.debug "ddddddddd #{params["multiple"]}"
  params[:product].each do |product_params|
    product_params.permit!
    @productObj = Product.new
    @productObj.name = product_params["name"]
    if @productObj.price != 50
      @productObj.price = product_params["price"]  
    else
      @productObj.price = 50
    end
    
    d = DateTime.now
    @productObj.available_on = d.strftime("%d/%m/%Y %H:%M")
    @productObj.shipping_category_id = product_params["shipping_category_id"]
    @productObj.sku = product_params["sku"]
    #@productObj.product_variant_desc = "#{product_params["txtvariant_0"]}#{','}#{product_params["txtvariant_1"]}#{','}#{product_params["txtvariant_2"]}"
    @productTaxon = product_params["taxon_ids"]
    @quantity = product_params["quantity"]
    @productObj.vendor_id = spree_current_user.supplier_id
    @productObj.promotionable = false
    logger.debug "with taxons #{product_params["taxon_ids"]}"
    print product_params["taxon_ids"]

    params[:images].each do |product_images|
      image = Image.create(:attachment =>File.open(product_images["image"].path) ,:viewable => @productObj)
      @productObj.images << image
    end

    @optionValue = @productObj.product_option_types.new({:product_id=>@productObj.id, :option_type_id=>1})
    @optionValue.save
    @optionType = @productObj.product_option_types.new({:product_id=>@productObj.id, :option_type_id=>2})
    @optionType.save

    @productObj.save
    product_params["taxon_ids"] = product_params["taxon_ids"].split(',')
    @productObj.assign_attributes(taxons:Spree::Taxon.find(product_params["taxon_ids"]))

    if product_params["is_single"] == 'yes'
        @optionValue = Spree::OptionValue.where(id:[product_params["master_types_0"],product_params["master_types_1"],product_params["master_types_2"]])
        @variantnewObj =  Spree::Variant.create!({:product_id => @productObj.id, :sku => "", :cost_price => product_params["price"], :is_master => true, :option_values => @optionValue})
        @productObj.variants << @variantnewObj
        if product_params["price"] != 50
          Spree::Price.create!({:variant_id => @variantnewObj.id, :amount => product_params["price"]})
        end
        Spree::Price.where(:variant_id => @variantnewObj.id , :amount => product_params["price"] ).first.destroy
        @stocklocation = Spree::StockLocation.find_by(supplier_id:spree_current_user.supplier_id)
        @stockObj = Spree::StockItem.create!(:stock_location_id => @stocklocation.id ,:variant_id => @variantnewObj.id , :count_on_hand => 0, :backorderable => false)
        @staockMovementObj = Spree::StockMovement.new
        @staockMovementObj.stock_item_id = @stockObj.id
        @staockMovementObj.quantity = product_params["quantity"]
        @staockMovementObj.save
        @supplierObj = Spree::Supplier.find_by(id:spree_current_user.supplier_id)
        @suppliervariant = @supplierObj.supplier_variants.new(:supplier_id => @supplierObj.id, :variant_id => @variantnewObj.id)
        @suppliervariant.save
        Spree::StockItem.find_by(variant_id:@variantnewObj).update(backorderable: false)
    end

    unless params[:variant].nil?
      params[:variant].each do |variant_params|
        logger.debug "@iamgesssssssssss #{variant_params["price"]}"
        @optionValue = Spree::OptionValue.where(id:[variant_params["option_types_0"],variant_params["option_types_1"],variant_params["option_types_2"]])
        logger.debug "Creating Variants #{@productObj.id}"
        @variantnewObj =  Spree::Variant.create!({:product_id => @productObj.id, :sku => "", :cost_price => variant_params["price"], :is_master => false, :option_values => @optionValue, :mrp => variant_params["mrp"]})
        @productObj.variants << @variantnewObj
        @productObj.save
        logger.debug "@variantnewObj #{@variantnewObj.id}"
        if variant_params["price"] != 50
          Spree::Price.create!({:variant_id => @variantnewObj.id, :amount => variant_params["price"]})
        end
        Spree::Price.where(:variant_id => @variantnewObj.id , :amount => product_params["price"] ).first.destroy
        @stocklocation = Spree::StockLocation.find_by(supplier_id:spree_current_user.supplier_id)
        @stockObj = Spree::StockItem.create!(:stock_location_id => @stocklocation.id ,:variant_id => @variantnewObj.id , :count_on_hand => 0, :backorderable => false)
        @staockMovementObj = Spree::StockMovement.new
        @staockMovementObj.stock_item_id = @stockObj.id
        @staockMovementObj.quantity = variant_params["quantity"]
        @staockMovementObj.save
        @supplierObj = Spree::Supplier.find_by(id:spree_current_user.supplier_id)
        @suppliervariant = @supplierObj.supplier_variants.new(:supplier_id => @supplierObj.id, :variant_id => @variantnewObj.id)
        @suppliervariant.save
        Spree::StockItem.find_by(variant_id:@variantnewObj).update(backorderable: false)
        varimage = Image.create(:attachment =>File.open(variant_params["image"].path) ,:viewable => @variantnewObj)
        @variantnewObj.images << varimage
      end
    end
        @productObj.save
        firstvariant = Spree::Variant.find_by(sku: @productObj.sku)
        @supplierObj1 = Spree::Supplier.find_by(id:spree_current_user.supplier_id)
        @suppliervariant1 = @supplierObj1.supplier_variants.new(:supplier_id => @supplierObj1.id, :variant_id => firstvariant.id)
        @suppliervariant1.save
  end
        flash[:success] = "Product Uploaded Successfully"
        redirect_to edit_admin_product_url(@productObj)
         #redirect_to new_object_url
end
  
      def update
        if params[:product][:taxon_ids].present?
          params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
        end
        if params[:product][:option_type_ids].present?
          params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
        end
        invoke_callbacks(:update, :before)
        if @object.update_attributes(permitted_resource_params)
          invoke_callbacks(:update, :after)
          flash[:success] = flash_message_for(@object, :successfully_updated)
          respond_with(@object) do |format|
            format.html { redirect_to location_after_save }
            format.js   { render layout: false }
          end
        else
          # Stops people submitting blank slugs, causing errors when they try to
          # update the product again
          @product.slug = @product.slug_was if @product.slug.blank?
          invoke_callbacks(:update, :fails)
          respond_with(@object)
        end
      end

      def destroy
        @product = Product.friendly.find(params[:id])

        begin
          # TODO: why is @product.destroy raising ActiveRecord::RecordNotDestroyed instead of failing with false result
          if @product.destroy
            flash[:success] = Spree.t('notice_messages.product_deleted')
          else
            flash[:error] = Spree.t('notice_messages.product_not_deleted', error: @product.errors.full_messages.to_sentence)
          end
        rescue ActiveRecord::RecordNotDestroyed => e
          flash[:error] = Spree.t('notice_messages.product_not_deleted', error: e.message)
        end

        respond_with(@product) do |format|
          format.html { redirect_to collection_url }
          format.js { render_js_for_destroy }
        end
      end

      def clone
        @new = @product.duplicate

        if @new.persisted?
          flash[:success] = Spree.t('notice_messages.product_cloned')
          redirect_to edit_admin_product_url(@new)
        else
          flash[:error] = Spree.t('notice_messages.product_not_cloned', error: @new.errors.full_messages.to_sentence)
          redirect_to admin_products_url
        end
      rescue ActiveRecord::RecordInvalid => e
        # Handle error on uniqueness validation on product fields
        flash[:error] = Spree.t('notice_messages.product_not_cloned', error: e.message)
        redirect_to admin_products_url
      end

      def stock
        @variants = @product.variants.includes(*variant_stock_includes)
        @variants = [@product.master] if @variants.empty?
        @stock_locations = StockLocation.accessible_by(current_ability, :read)
        if @stock_locations.empty?
          flash[:error] = Spree.t(:stock_management_requires_a_stock_location)
          redirect_to admin_stock_locations_path
        end
      end

      protected

      def find_resource
        Product.with_deleted.friendly.find(params[:id])
      end

      def location_after_save
        spree.edit_admin_product_url(@product)
      end

      def load_data
        @taxons = Taxon.order(:name)
        @option_types = OptionType.order(:name)
        @tax_categories = TaxCategory.order(:name)
        @shipping_categories = ShippingCategory.order(:name)
      end

      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= '1'
        params[:q][:not_discontinued] ||= '1'

        params[:q][:s] ||= 'name asc'
        @collection = super
        # Don't delete params[:q][:deleted_at_null] here because it is used in view to check the
        # checkbox for 'q[deleted_at_null]'. This also messed with pagination when deleted_at_null is checked.
        if params[:q][:deleted_at_null] == '0'
          @collection = @collection.with_deleted
        end
        # @search needs to be defined as this is passed to search_form_for
        # Temporarily remove params[:q][:deleted_at_null] from params[:q] to ransack products.
        # This is to include all products and not just deleted products.
        @search = @collection.ransack(params[:q].reject { |k, _v| k.to_s == 'deleted_at_null' })
        @collection = @search.result.
                      distinct_by_product_ids(params[:q][:s]).
                      includes(product_includes).
                      page(params[:page]).
                      per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end

      def create_before

       return if (params[:product][:prototype_id].to_i).blank?
        @prototype = Spree::Prototype.find(params[:product][:prototype_id].to_i)
      end

      def update_before
        # note: we only reset the product properties if we're receiving a post
        #       from the form on that tab
        return unless params[:clear_product_properties]
        params[:product] ||= {}
      end

      def product_includes
        [{ variants: [:images], master: [:images, :default_price] }]
      end

      def clone_object_url(resource)
        clone_admin_product_url resource
      end

      private

      def variant_stock_includes
        [:images, stock_items: :stock_location, option_values: :option_type]
      end
      def new
            render :partial => "products/variants"
         end
    end
  end
end
