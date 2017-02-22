Deface::Override.new(
  virtual_path: 'spree/orders/_line_item',
  name: 'add_alcoholic_product_note_in_line_item_form',
  insert_bottom: "[data-hook='cart_item_description']",
  partial: "spree/orders/alcoholic_product_note_in_line_item_form"
)
