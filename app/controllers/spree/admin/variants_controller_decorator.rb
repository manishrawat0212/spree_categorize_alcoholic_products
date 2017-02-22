Spree::Admin::VariantsController.class_eval do
  before_action :update_loaded_data, only: [:new, :create, :edit, :update]

  private
    def update_loaded_data
      @tax_categories = @tax_categories.non_alcoholic
    end
end
