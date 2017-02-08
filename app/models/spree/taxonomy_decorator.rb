Spree::Taxonomy.class_eval do
  before_destroy :update_associated_alcoholic_products, prepend: true

  def update_associated_alcoholic_products
    products = Spree::Product.joins(:taxons).where(spree_products_taxons: {taxon_id: taxons.alcoholic.pluck(:id)})
    products.update_as_non_alcoholic
  end
end
