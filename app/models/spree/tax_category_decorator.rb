Spree::TaxCategory.class_eval do
  Spree::TaxCategory::ALCOHOLIC = 'Alcohol'.freeze

  with_options if: :alcoholic? do
    before_update :alcohol_category_restriction_error
    before_destroy :alcohol_category_restriction_error
  end

  scope :non_alcoholic, -> { where.not(name: Spree::TaxCategory::ALCOHOLIC) }

  def alcoholic?
    name == Spree::TaxCategory::ALCOHOLIC
  end

  def alcohol_category_restriction_error
    errors.add(:base, Spree.t(:cannot_update_or_destroy_alcohol_tax_category))
    false
  end
end
