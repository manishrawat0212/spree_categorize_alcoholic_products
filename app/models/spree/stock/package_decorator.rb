module Spree
  module Stock
    Package.class_eval do
      def shipping_categories
        contents.map do |item|
          if item.variant.product.is_alcoholic? && (alcohol_shipping_category = Spree::ShippingCategory.find_by(name: 'Alcohol'))
            alcohol_shipping_category
          else
            item.variant.shipping_category
          end
        end.compact.uniq
      end
    end
  end
end
