Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'update_shipping_category_field_in_product_edit_form',
  replace: "erb[loud]:contains('f.collection_select(:shipping_category_id')",
  partial: "spree/admin/products/shipping_category_in_edit_product"
)
