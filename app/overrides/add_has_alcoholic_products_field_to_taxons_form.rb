Deface::Override.new(
  virtual_path: 'spree/admin/taxons/_form',
  name: 'add_has_alcoholic_products_field_to_taxons_form',
  insert_after: "[data-hook='admin_inside_taxon_form'] > .row",
  partial: "spree/admin/taxons/has_alcoholic_products_taxons_form"
)
