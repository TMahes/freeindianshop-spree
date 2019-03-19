require 'product_filters'
# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  admin_interface_logo = "logo/spree_50.png"
  config.products_per_page = 50
end
Spree::Auth::Config[:confirmable] = true
Spree.user_class = "Spree::User"
Spree::PermittedAttributes.user_attributes.push :first_name, :last_name, :dob, :city, :state, :zip_code, :address, :seller,:shop_name,:phone
attachment_config = {
    s3_credentials: {
        access_key_id: S3_CREDENTIALS['AWS_ACCESS_KEY'],
        secret_access_key: S3_CREDENTIALS['AWS_SECRET_TOKEN'],
        bucket: S3_CREDENTIALS['AWS_BUCKET']
    },
    storage:        :s3,
    s3_protocol:    "http",
    s3_region: "us-east-2",
    s3_host_name:   's3.us-east-2.amazonaws.com',
  url:            '/spree/:class/:id/:style/:basename.:extension',
  path:           '/spree/:class/:id/:style/:basename.:extension'
 }
attachment_config.each do |key, value|
    Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
end


  
