Spree::Product.class_eval do
  attr_accessor :taxons_changed

  has_many :taxons, through: :classifications, before_remove: :remove_taxon,
                                               after_add: :set_taxons_changed,
                                               after_remove: :set_taxons_changed

  with_options if: :taxons_changed do
    before_validation :set_alcoholic
    before_validation :set_tax_category
    before_validation :set_shipping_category
  end
  after_save :set_tax_category_of_variants, if: :has_variants?

  self.whitelisted_ransackable_attributes << "alcoholic"

  scope :alcoholic, -> { where(alcoholic: true) }
  scope :non_alcoholic, -> { where(alcoholic: false) }

  def set_taxons_changed(taxon)
    self.taxons_changed = true
  end

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

  def self.update_as_alcoholic
    tax_category_id = Spree::TaxCategory.find_by(name: Spree::TaxCategory::ALCOHOLIC).id
    update_all(
      alcoholic: true,
      tax_category_id: tax_category_id,
      shipping_category_id: Spree::ShippingCategory.find_by(name: Spree::ShippingCategory::ALCOHOLIC).id
    )
    Spree::Variant.non_master.where(product: self).update_all(
      tax_category_id: tax_category_id
    )
  end

  def self.update_as_non_alcoholic
    update_all(
      alcoholic: false,
      tax_category_id: nil,
      shipping_category_id: Spree::ShippingCategory.non_alcoholic.first.id
    )
    Spree::Variant.non_master.where(product: self).update_all(
      tax_category_id: nil
    )
  end
end
