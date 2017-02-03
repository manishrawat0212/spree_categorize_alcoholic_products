module Spree
  TaxCategory.class_eval do
    with_options if: :tax_category_is_alcohol? do
      before_update :restrict_with_error_message
      before_destroy :restrict_with_error_message
    end

    scope :non_alcoholic, -> { where.not(name: ALCOHOLIC_TAX_CATEGORY).order(:name) }

    def tax_category_is_alcohol?
      self.name == ALCOHOLIC_TAX_CATEGORY
    end

    def restrict_with_error_message
      self.errors.add(:base, Spree.t(:cannot_update_or_destroy_alcohol_tax_category))
      false
    end
  end
end
