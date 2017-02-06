module Spree
  Taxon.class_eval do
    before_validation :update_alcoholic_field, if: :parent_taxon_is_alcoholic?
    after_update :save_products, if: :alcoholic_changed?
    with_options if: :alcoholic? do
      after_save :update_children
      before_destroy :update_associated_products, prepend: true
    end

    scope :alcoholic, -> { where(alcoholic: true) }
    scope :not_alcoholic, -> { where(alcoholic: false) }

    def parent_taxon_is_alcoholic?
      parent && parent.alcoholic?
    end

    def update_children
      children.not_alcoholic.each do |child|
        child.update(alcoholic: true)
      end
    end

    def update_alcoholic_field
      self.alcoholic = true
    end

    def save_products
      self.products.find_each do |product|
        product.save
      end
    end

    def update_associated_products
      products = self.products.select { |p| p.taxons.where.not(id: self).alcoholic.none? }
      products.each do |product|
        product.update_columns(
          alcoholic: false,
          tax_category_id: nil,
          shipping_category_id: ShippingCategory.non_alcoholic.first.id
        )
        product.variants.update_all(tax_category_id: nil)
      end
    end
  end
end
