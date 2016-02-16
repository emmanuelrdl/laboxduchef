ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

permit_params :user_id, :status, :amount_cents, :payment, :quantity, :meal_id

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :status
      f.input :amount_cents
      f.input :quantity
      f.input :meal_id
      f.input :payment,  as: :hstore
    end
    f.actions
  end
#
 
  filter :meal_id,  collection: proc { Meal.all }, as: :select
  filter :created_at
  filter :updated_at
  filter :status  
  filter :user_id

  
end
