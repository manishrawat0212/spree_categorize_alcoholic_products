Spree::Admin::ProductsController.class_eval do
  before_action :update_loaded_data, except: :index

  protected
    def update_loaded_data
      @tax_categories = @tax_categories.non_alcoholic
      @shipping_categories = @shipping_categories.non_alcoholic
    end
end
