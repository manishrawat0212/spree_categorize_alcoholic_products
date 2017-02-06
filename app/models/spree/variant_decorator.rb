module Spree
  Variant.class_eval do
    before_save :update_tax_category_to_alcohol, if: :product_is_alcohoic?

    delegate_belongs_to :product, :alcoholic?

    def product_is_alcohoic?
      !is_master? && alcoholic?
    end

    def update_tax_category_to_alcohol
      self.tax_category = self.product.tax_category
    end
  end
end
