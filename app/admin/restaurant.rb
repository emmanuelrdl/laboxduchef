ActiveAdmin.register Restaurant do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :user_id, :name, :locality, :postal_code, :phone_number, :latitude,
 :longitude, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at,
 :street, :confirmed, :iban, :take_away_noon_starts_at, :take_away_noon_ends_at, :take_away_evening_starts_at,
 :take_away_evening_ends_at, :id , :commit
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
