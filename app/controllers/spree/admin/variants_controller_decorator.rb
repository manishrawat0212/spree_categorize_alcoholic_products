module Spree
  module Admin
    VariantsController.class_eval do
      private
        alias_method :original_load_data, :load_data
        def load_data
          original_load_data
          @tax_categories = TaxCategory.where.not(name: 'Alcohol').order(:name)
        end
    end
  end
end
