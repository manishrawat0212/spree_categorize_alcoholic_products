module Spree
  module Admin
    VariantsController.class_eval do
      before_action :update_loaded_data, only: [:new, :create, :edit, :update]
      before_action :load_alcohol_tax_category, only: [:new, :create, :edit, :update]

      private
        def update_loaded_data
          @tax_categories = TaxCategory.non_alcoholic
        end

        def load_alcohol_tax_category
          @alcohol_tax_category = TaxCategory.find_by(name: ALCOHOLIC_TAX_CATEGORY)
        end
    end
  end
end
