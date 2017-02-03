module Spree
  module Admin
    ProductsController.class_eval do
      before_action :update_loaded_data, except: :index
      before_action :load_alcohol_tax_and_shipping_category, except: :index

      protected
        def update_loaded_data
          @tax_categories = TaxCategory.non_alcoholic
          @shipping_categories = ShippingCategory.non_alcoholic
        end

        def load_alcohol_tax_and_shipping_category
          @alcohol_tax_category = TaxCategory.find_by(name: ALCOHOLIC_TAX_CATEGORY)
          @alcohol_shipping_category = ShippingCategory.find_by(name: ALCOHOLIC_SHIPPING_CATEGORY)
        end
    end
  end
end
