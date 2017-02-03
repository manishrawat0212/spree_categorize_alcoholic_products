Deface::Override.new(
  virtual_path: 'spree/admin/variants/_form',
  name: 'update_tax_category_field_in_variant_edit_form',
  replace: "erb[loud]:contains('f.collection_select(:tax_category_id')",
  partial: "spree/admin/variants/tax_category_in_edit_variant"
)
