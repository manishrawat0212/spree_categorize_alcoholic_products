module Spree
  module Stock
    module Splitter
      ShippingCategory.class_eval do
        private

        def split_by_category(package)
          categories = Hash.new { |hash, key| hash[key] = [] }
          package.contents.each do |item|
            if item.variant.product.is_alcoholic? && (alcohol_shipping_category = Spree::ShippingCategory.find_by(name: 'Alcohol'))
              categories[alcohol_shipping_category.id] << item
            else
              categories[item.variant.shipping_category_id] << item
            end
          end
          hash_to_packages(categories)
        end
      end
    end
  end
end
