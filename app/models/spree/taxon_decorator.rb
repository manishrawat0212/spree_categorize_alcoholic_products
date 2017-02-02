module Spree
  Taxon.class_eval do
    before_validation :update_has_alcoholic_products_field, if: :parent_taxon_has_alcoholic_products?
    after_save :update_children, if: :has_alcoholic_products?

    scope :have_alcoholic_products, -> { where(has_alcoholic_products: true) }
    scope :do_not_have_alcoholic_products, -> { where(has_alcoholic_products: false) }

    def parent_taxon_has_alcoholic_products?
      taxon.parent && taxon.parent.has_alcoholic_products?
    end

    def update_children
      children.do_not_have_alcoholic_products.each do |child|
        child.update(has_alcoholic_products: true)
      end
    end

    def update_has_alcoholic_products_field
      self.has_alcoholic_products = true
    end
  end
end
