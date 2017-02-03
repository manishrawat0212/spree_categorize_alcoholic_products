module Spree
  LineItem.class_eval do
    delegate_belongs_to :product, :alcoholic?
  end
end
