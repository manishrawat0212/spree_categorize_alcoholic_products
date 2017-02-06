module Spree
  module Admin
    VariantsController.class_eval do
      before_action :update_loaded_data, only: [:new, :create, :edit, :update]

      private
        def update_loaded_data
          @tax_categories = TaxCategory.non_alcoholic
        end
    end
  end
end
