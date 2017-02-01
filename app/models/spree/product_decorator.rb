module Spree
  Product.class_eval do
    def is_alcoholic?
      taxons.any? { |t| t.has_alcoholic_products == true }
    end
  end
end
