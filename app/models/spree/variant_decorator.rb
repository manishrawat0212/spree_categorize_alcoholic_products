module Spree
  Variant.class_eval do
    before_save :update_tax_category_to_alcohol, if: Proc.new { |v| !v.is_master? && v.alcoholic? }

    delegate_belongs_to :product, :alcoholic?

    def update_tax_category_to_alcohol
      self.tax_category = self.product.tax_category
    end
  end
end
