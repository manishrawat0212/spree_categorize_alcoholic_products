module Spree
  Variant.class_eval do
    delegate_belongs_to :product, :is_alcoholic?

    def shipping_category
      if is_alcoholic?
        Spree::ShippingCategory.find_by(name: 'Alcohol') || product.shipping_category
      else
        product.shipping_category
      end
    end

    def shipping_category_id
      shipping_category.id
    end
  end
end
