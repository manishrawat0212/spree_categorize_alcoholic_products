Spree::TaxCategory.find_or_create_by(name: 'Alcohol') do |tax_category|
  tax_category.tax_code = 'alcohol'
  tax_category.description = 'Tax category that represents alcoholic products.'
  tax_category.is_default = false
end

Spree::ShippingCategory.find_or_create_by(name: 'Alcohol')
