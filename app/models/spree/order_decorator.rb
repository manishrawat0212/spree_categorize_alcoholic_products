module Spree
  Order.class_eval do
    alias_method :original_create_tax_charge!, :create_tax_charge!

    def create_tax_charge!
      original_create_tax_charge!
      TaxRate.adjust_alcoholic_product(self, line_items)
    end
  end
end
