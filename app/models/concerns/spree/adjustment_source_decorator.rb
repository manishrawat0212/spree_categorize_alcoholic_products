Spree::AdjustmentSource.class_eval do
  protected
    def create_alcoholic_product_adjustment(order, adjustable, included = nil)
      amount = compute_amount(adjustable)
      return if amount == 0

      adjustments.new(order: order,
                      adjustable: adjustable,
                      amount: amount,
                      label: label,
                      included: included).save
    end
end
