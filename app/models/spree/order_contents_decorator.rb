module Spree
  OrderContents.class_eval do
    private
      alias_method :original_after_add_or_remove, :after_add_or_remove

      def after_add_or_remove(line_item, options = {})
        original_after_add_or_remove(line_item, options = {})
        TaxRate.adjust_alcoholic_product(order, [line_item]) if line_item.is_alcoholic? && options[:line_item_created]
        persist_totals
        line_item
      end
  end
end
