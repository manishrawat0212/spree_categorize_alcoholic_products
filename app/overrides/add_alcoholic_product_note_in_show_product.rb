Deface::Override.new(
  virtual_path: 'spree/products/_cart_form',
  name: 'add_alcoholic_product_note_in_show_product',
  insert_after: "[data-hook='product_price'] > #product-price > div",
  partial: "spree/products/alcoholic_product_note_in_show_product"
)
