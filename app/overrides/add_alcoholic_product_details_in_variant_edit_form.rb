Deface::Override.new(
  virtual_path: 'spree/admin/variants/_form',
  name: 'add_alcoholic_product_details_in_variant_edit_form',
  insert_after: "[data-hook='tax_category']",
  partial: "spree/admin/variants/alcoholic_product_details_in_edit_variant"
)
