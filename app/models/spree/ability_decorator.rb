module Spree
  class AbilityDecorator
    include CanCan::Ability

    def initialize user
      cannot [:update, :destroy], TaxCategory, name: [ALCOHOLIC_TAX_CATEGORY]
      cannot [:update, :destroy], ShippingCategory, name: [ALCOHOLIC_SHIPPING_CATEGORY]
    end
  end
end

Spree::Ability.register_ability(Spree::AbilityDecorator)
