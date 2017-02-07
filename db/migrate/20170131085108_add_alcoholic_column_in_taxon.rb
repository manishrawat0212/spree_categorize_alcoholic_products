class AddAlcoholicColumnInTaxon < ActiveRecord::Migration
  def change
    add_column :spree_taxons, :alcoholic, :boolean, default: false, null: false
    add_index :spree_taxons, :alcoholic
  end
end
