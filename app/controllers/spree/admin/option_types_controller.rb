module Spree
  module Admin
    class OptionTypesController < ResourceController
      before_action :setup_new_option_value, only: :edit

      def update_values_positions
        ApplicationRecord.transaction do
          params[:positions].each do |id, index|
            Spree::OptionValue.where(id: id).update_all(position: index)
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_product_variants_url(params[:product_id]) }
          format.js { render plain: 'Ok' }
        end
      end

  def update
    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      invoke_callbacks(:update, :after)
      respond_with(@object) do |format|
        format.html do
          flash[:success] = flash_message_for(@object, :successfully_updated)
          redirect_to location_after_save
        end
        format.js { render layout: false }
      end
    else
      invoke_callbacks(:update, :fails)
      respond_with(@object) do |format|
        format.html { render action: :edit }
        format.js { render layout: false }
      end
    end
  end

      protected

      def location_after_save
        if @option_type.created_at == @option_type.updated_at
          edit_admin_option_type_url(@option_type)
        else
          admin_option_types_url
        end
      end

      private

      def setup_new_option_value
        
        @option_type.option_values.build if @option_type.option_values.empty?

      end
      def permitted_resource_params
        params[resource.object_name].present? ? params.require(resource.object_name).permit! : ActionController::Parameters.new
      end
    end
  end
end
