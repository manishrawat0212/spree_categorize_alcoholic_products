class AddAlcoholicColumnInProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :alcoholic, :boolean, default: false, null: false
    add_index :spree_products, :alcoholic
  end
end
