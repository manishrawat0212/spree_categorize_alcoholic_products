Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'add_alcoholic_products_search',
  insert_bottom: "[data-hook='admin_products_index_search'] > .col-md-12",
  partial: "spree/admin/products/alcoholic_products_search_form"
)
