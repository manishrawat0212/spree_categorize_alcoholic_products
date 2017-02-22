Spree::Taxonomy.class_eval do
  before_destroy :update_associated_alcoholic_products, prepend: true

  def update_associated_alcoholic_products
    associated_products = Spree::Product.where(id: taxons.map(&:product_ids).flatten)
    still_alcoholic_product_ids = associated_products.joins(:taxons).where(spree_taxons: {alcoholic: true}).where.not(spree_taxons: {id: taxon_ids}).distinct.pluck(:id)
    associated_products.where.not(id: still_alcoholic_product_ids).update_as_non_alcoholic
  end
end
