Spree::Variant.class_eval do
  before_validation :set_tax_category, if: :product_is_alcoholic?

  delegate_belongs_to :product, :alcoholic?

  scope :non_master, -> { where(is_master: false) }

  def product_is_alcoholic?
    !is_master? && alcoholic?
  end

  def set_tax_category
    self.tax_category = product.tax_category
  end
end
