module Spree
  Taxon.class_eval do
    after_save :update_children, if: :has_alcoholic_products?

    scope :have_alcoholic_products, -> { where(has_alcoholic_products: true) }
    scope :do_not_have_alcoholic_products, -> { where(has_alcoholic_products: false) }

    def update_children
      children.do_not_have_alcoholic_products.each do |child|
        child.update(has_alcoholic_products: true)
      end
    end
  end
end
