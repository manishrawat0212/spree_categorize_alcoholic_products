module Spree
  LineItem.class_eval do
    with_options if: :is_alcoholic? do
      after_create :update_alcoholic_product_tax_charge
      after_save :update_alcoholic_product_tax_adjustments, if: :quantity_changed?
    end

    delegate_belongs_to :product, :is_alcoholic?

    def update_alcoholic_product_tax_adjustments
      recalculate_adjustments
      update_alcoholic_product_tax_charge
    end

    def update_alcoholic_product_tax_charge
      TaxRate.adjust_alcoholic_product(order, [self])
    end
  end
end
