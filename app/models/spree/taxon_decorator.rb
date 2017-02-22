Spree::Taxon.class_eval do
  before_validation :set_alcoholic, if: :parent_taxon_is_alcoholic?
  before_update :update_associated_products, if: :alcoholic_changed?
  with_options if: :alcoholic? do
    after_update :update_non_alcoholic_descendants
    before_destroy :update_associated_alcoholic_products, prepend: true
  end

  scope :alcoholic, -> { where(alcoholic: true) }
  scope :non_alcoholic, -> { where(alcoholic: false) }

  def parent_taxon_is_alcoholic?
    parent && parent.alcoholic?
  end

  def update_non_alcoholic_descendants
    products = Spree::Product.joins(:taxons).where(spree_products_taxons: {taxon_id: descendants.non_alcoholic.pluck(:id)})
    products.update_as_alcoholic
    descendants.non_alcoholic.update_all(alcoholic: true)
  end

  def set_alcoholic
    self.alcoholic = true
  end

  def update_associated_products
    if alcoholic?
      products.update_as_alcoholic
    else
      update_associated_alcoholic_products
    end
  end

  def update_associated_alcoholic_products
    products_to_be_marked_as_non_alcoholic = products.joins(:taxons).where(spree_taxons: {alcoholic: true}).group("id").having("count(spree_taxons.id) = 1")
    products_to_be_marked_as_non_alcoholic.update_as_non_alcoholic
  end
end
