Spree::Product.class_eval do
  before_validation :set_alcoholic
  before_validation :set_tax_category
  before_validation :set_shipping_category
  after_save :set_tax_category_of_variants, if: :has_variants?

  self.whitelisted_ransackable_attributes << "alcoholic"

  def added_in_alcoholic_taxon?
    taxons.alcoholic.exists?
  end

  def set_alcoholic
    self.alcoholic = added_in_alcoholic_taxon? ? true : false
    true
  end

  def set_tax_category
    alcohol_tax_category = Spree::TaxCategory.find_by(name: Spree::TaxCategory::ALCOHOLIC)
    if added_in_alcoholic_taxon?
      self.tax_category = alcohol_tax_category
    elsif tax_category_id_was == alcohol_tax_category.id
      self.tax_category = nil
    end
  end

  def set_shipping_category
    alcohol_shipping_category = Spree::ShippingCategory.find_by(name: Spree::ShippingCategory::ALCOHOLIC)
    if added_in_alcoholic_taxon? && alcohol_shipping_category
      self.shipping_category = alcohol_shipping_category
    elsif !added_in_alcoholic_taxon? && shipping_category == alcohol_shipping_category
      self.shipping_category = Spree::ShippingCategory.non_alcoholic.first
    end
  end

  def set_tax_category_of_variants
    if alcoholic?
      variants.update_all(tax_category_id: tax_category_id)
    elsif alcoholic_changed?(from: true, to: false)
      variants.update_all(tax_category_id: nil)
    end
  end
end
