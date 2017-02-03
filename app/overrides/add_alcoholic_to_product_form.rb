Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_alcoholic_to_product_form',
  insert_before: "[data-hook='admin_product_form_shipping_categories']",
  text: "
    <div data-hook='admin_product_form_alcoholic'>
      <%= f.field_container :alcoholic, class: ['form-group'] do %>
        <%= f.label :alcoholic, Spree.t(:alcoholic) %>
        <%= f.error_message_on :alcoholic %>
        <%= f.check_box :alcoholic, class: 'form-control' %>
      <% end %>
    </div>
  "
)
