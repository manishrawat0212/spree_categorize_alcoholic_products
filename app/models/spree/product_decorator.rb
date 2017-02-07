module Spree
  Product.class_eval do
    before_save :update_alcoholic_field
    before_save :update_tax_category
    before_save :update_shipping_category
    after_save :update_tax_category_of_variants, if: :has_variants?

    self.whitelisted_ransackable_attributes << "alcoholic"

    def added_in_alcoholic_taxon?
      taxons.alcoholic.exists?
    end

    def update_alcoholic_field
      self.alcoholic = self.added_in_alcoholic_taxon? ? true : false
      return true
    end

    def update_tax_category
      alcohol_tax_category = TaxCategory.find_by(name: ALCOHOLIC_TAX_CATEGORY)
      if self.added_in_alcoholic_taxon?
        self.tax_category = alcohol_tax_category
      elsif self.tax_category_id_was == alcohol_tax_category.id
        self.tax_category = nil
      end
    end

    def update_shipping_category
      alcohol_shipping_category = ShippingCategory.find_by(name: ALCOHOLIC_SHIPPING_CATEGORY)
      if self.added_in_alcoholic_taxon? && alcohol_shipping_category
        self.shipping_category = alcohol_shipping_category
      elsif !self.added_in_alcoholic_taxon? && self.shipping_category == alcohol_shipping_category
        self.shipping_category = ShippingCategory.non_alcoholic.first
      end
    end

    def update_tax_category_of_variants
      if self.alcoholic?
        self.variants.update_all(tax_category_id: self.tax_category_id)
      elsif self.alcoholic_changed?(from: true, to: false)
        self.variants.update_all(tax_category_id: nil)
      end
    end
  end
end
