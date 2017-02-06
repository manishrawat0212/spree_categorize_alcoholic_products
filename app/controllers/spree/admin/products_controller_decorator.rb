module Spree
  module Admin
    ProductsController.class_eval do
      before_action :update_loaded_data, except: :index

      protected
        def update_loaded_data
          @tax_categories = TaxCategory.non_alcoholic
          @shipping_categories = ShippingCategory.non_alcoholic
        end
    end
  end
end
