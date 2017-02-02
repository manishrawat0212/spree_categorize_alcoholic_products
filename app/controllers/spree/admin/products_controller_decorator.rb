module Spree
  module Admin
    ProductsController.class_eval do
      before_action :update_loaded_data, except: :index

      protected
        def update_loaded_data
          @tax_categories = TaxCategory.where.not(name: 'Alcohol').order(:name)
          @shipping_categories = ShippingCategory.where.not(name: 'Alcohol').order(:name)
        end
    end
  end
end
