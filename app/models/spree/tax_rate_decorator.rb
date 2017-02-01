module Spree
  TaxRate.class_eval do
    def self.adjust_alcoholic_product(order, items)
      alcoholic_tax_category = TaxCategory.find_by(name: 'Alcohol')
      return if alcoholic_tax_category.nil?

      tax_rate_for_alcohol = alcoholic_tax_category.tax_rates.find_by(zone: order.tax_zone)
      return if tax_rate_for_alcohol.nil?

      items.each do |item|
        tax_rate_for_alcohol.adjust_alcoholic_product(order, item) if item.is_alcoholic?
      end
    end

    def adjust_alcoholic_product(order, line_item)
      create_alcoholic_product_adjustment(order, line_item, included_in_price)
    end
  end
end
