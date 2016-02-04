ActiveAdmin.register Meal do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :restaurant_id, :name, :quantity, :description, :starting_date, :second_date,
:picture_file_name, :picure_content_type, :picture_file_size, :picture_updated_at, :active,
:price_cents, :stock, :seated_price, :take_away_noon, :take_away_evening, :permanent
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
