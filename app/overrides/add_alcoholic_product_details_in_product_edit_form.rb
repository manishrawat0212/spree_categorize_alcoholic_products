Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_alcoholic_product_details_in_product_edit_form',
  insert_after: "[data-hook='admin_product_form_taxons']",
  partial: "spree/products/alcoholic_product_details_in_edit_product"
)
