module Spree
  module Admin
    VariantsController.class_eval do
      before_action :update_loaded_data, only: [:new, :create, :edit, :update]

      private
        def update_loaded_data
          @tax_categories = TaxCategory.where.not(name: 'Alcohol').order(:name)
        end
    end
  end
end
