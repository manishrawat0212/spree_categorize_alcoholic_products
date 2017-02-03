Spree::TaxCategory.find_or_create_by(name: ALCOHOLIC_TAX_CATEGORY) do |tax_category|
  tax_category.tax_code = 'alcohol'
  tax_category.description = 'Tax category for alcoholic products.'
  tax_category.is_default = false
end

Spree::ShippingCategory.find_or_create_by(name: ALCOHOLIC_SHIPPING_CATEGORY)
