class RenameHasAlcoholicProductsColumnInTaxon < ActiveRecord::Migration
  def change
    rename_column :spree_taxons, :has_alcoholic_products, :alcoholic
  end
end
