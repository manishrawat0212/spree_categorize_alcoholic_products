Deface::Override.new(
  virtual_path: 'spree/shared/_order_details',
  name: 'add_alcoholic_product_note_in_order_details',
  insert_bottom: "[data-hook='order_item_description']",
  partial: "spree/shared/alcoholic_product_note_in_order_details"
)
