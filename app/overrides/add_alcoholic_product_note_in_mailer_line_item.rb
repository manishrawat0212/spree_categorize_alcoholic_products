Deface::Override.new(
  virtual_path: 'spree/shared/_mailer_line_item',
  name: 'add_alcoholic_product_note_in_mailer_line_item',
  insert_bottom: "tr > td:first-child",
  partial: "spree/shared/alcoholic_product_note_in_mailer_line_item"
)
