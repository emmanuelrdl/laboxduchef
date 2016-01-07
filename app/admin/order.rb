ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

permit_params :user_id, :status, :amount_cents, :payment

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :status
      f.input :amount_cents
      f.input :payment,  as: :hstore
    end
    f.actions
  end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
