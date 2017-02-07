Spree::Taxon.class_eval do
  before_validation :set_alcoholic, if: :parent_taxon_is_alcoholic?
  after_update :update_associated_products, if: :alcoholic_changed?
  with_options if: :alcoholic? do
    after_save :update_non_alcoholic_descendants
    before_destroy :update_associated_alcoholic_products, prepend: true
  end

  scope :alcoholic, -> { where(alcoholic: true) }
  scope :non_alcoholic, -> { where(alcoholic: false) }

  def parent_taxon_is_alcoholic?
    parent && parent.alcoholic?
  end

  def update_non_alcoholic_descendants
    descendants.non_alcoholic.update_all(alcoholic: true)
  end

  def set_alcoholic
    self.alcoholic = true
  end

  def update_associated_products
    if alcoholic?
      alcoholic = true
      tax_category_id = Spree::TaxCategory.find_by(name: Spree::TaxCategory::ALCOHOLIC).id
      shipping_category_id = Spree::ShippingCategory.find_by(name: Spree::ShippingCategory::ALCOHOLIC).id
      variants_tax_category_id = tax_category_id
    else
      alcoholic = false
      tax_category_id = nil
      shipping_category_id = Spree::ShippingCategory.non_alcoholic.first.id
      variants_tax_category_id = nil
    end

    products.update_all(
      alcoholic: alcoholic,
      tax_category_id: tax_category_id,
      shipping_category_id: shipping_category_id
    )
    Spree::Variant.non_master.where(product: products).update_all(
      tax_category_id: variants_tax_category_id
    )
  end

  def update_associated_alcoholic_products
    still_alcoholic_product_ids = products.joins(:taxons).where(spree_taxons: {alcoholic: true}).where.not(spree_taxons: {id: id}).distinct.pluck(:id)
    products_to_be_marked_non_alcoholic = products.where(id: product_ids - still_alcoholic_product_ids)

    products_to_be_marked_non_alcoholic.update_all(
      alcoholic: false,
      tax_category_id: nil,
      shipping_category_id: Spree::ShippingCategory.non_alcoholic.first.id
    )

    Spree::Variant.non_master.where(product: products_to_be_marked_non_alcoholic).update_all(
      tax_category_id: nil
    )
  end
end
