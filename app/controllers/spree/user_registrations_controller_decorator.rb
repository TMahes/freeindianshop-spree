Spree::UserRegistrationsController.class_eval do

    
         def create
         	logger.debug "fromlocaleee"
         	logger.debug "test #{params[:spree_user][:seller]}"
    @user = build_resource(spree_user_params)
    resource_saved = resource.save

    #Adding supplier
    if params[:spree_user][:seller] == 'yes'
        		logger.debug "Seller Registration #{resource.id}"
        		@object = Spree::Supplier.new(:active => true,:email => params[:spree_user][:email],:name => params[:spree_user][:shop_name],:url => params[:spree_user][:shop_name] )
        		@object.save
        		logger.debug "#{@object.id}"
    			@rolesObj = Spree::Role.find_by(name:'Sellers')
    			logger.debug "Role ID #{@rolesObj.id}"
    			logger.debug "Role ID #{resource.id}"
    			@rolesUserObj = @rolesObj.role_users.new(:role_id => @rolesObj.id, :user_id => resource.id)
    			@rolesUserObj.save
    			@userObj = Spree.user_class.find_by(id:resource.id)
          logger.debug "update#{@userObj.id}"
          @userObj.update(supplier_id:@object.id)
          logger.debug "update#{@userObj.supplier_id}"
          a = Geokit::Geocoders::GoogleGeocoder.geocode(params[:spree_user][:zip_code])
          logger.debug "=====#{a.ll}"
          ll = (a.ll).split(',')
          @distanceObject = Spree::Distance.new(:zipcode => params[:spree_user][:zip_code],:latitude => ll[0],:longitude => ll[1])
          @distanceObject.save
    			
    end
    
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_up(resource_name, resource)
        session[:spree_user_signup] = true
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      render :new
    end
  end
end