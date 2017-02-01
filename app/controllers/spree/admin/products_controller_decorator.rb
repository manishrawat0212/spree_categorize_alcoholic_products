module Spree
  module Admin
    ProductsController.class_eval do
      protected
        alias_method :original_load_data, :load_data
        def load_data
          original_load_data
          @tax_categories = TaxCategory.where.not(name: 'Alcohol').order(:name)
        end
    end
  end
end
