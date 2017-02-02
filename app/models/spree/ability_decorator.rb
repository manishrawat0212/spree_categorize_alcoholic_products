module Spree
  class AbilityDecorator
    include CanCan::Ability

    def initialize user
      cannot [:update, :destroy], TaxCategory, name: ['Alcohol']
      cannot [:update, :destroy], ShippingCategory, name: ['Alcohol']
    end
  end
end

Spree::Ability.register_ability(Spree::AbilityDecorator)
