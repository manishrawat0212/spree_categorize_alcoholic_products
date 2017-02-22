module Spree
  class AlcoholAbility
    include CanCan::Ability

    def initialize user
      cannot [:update, :destroy], TaxCategory, name: [Spree::TaxCategory::ALCOHOLIC]
      cannot [:update, :destroy], ShippingCategory, name: [Spree::ShippingCategory::ALCOHOLIC]
    end
  end
end

Spree::Ability.register_ability(Spree::AlcoholAbility)
