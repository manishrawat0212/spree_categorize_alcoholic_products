class AddHasAlcoholicProductsColumnInTaxon < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :has_alcoholic_products, :boolean, default: false, null: false
    add_index :spree_taxons, :has_alcoholic_products
  end
end
