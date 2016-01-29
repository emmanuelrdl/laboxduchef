ActiveAdmin.register Restaurant do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :user_id, :name, :locality, :postal_code, :phone_number, :latitude,
 :longitude, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at,
 :street, :confirmed, :iban, :take_away_noon_starts_at, :take_away_noon_ends_at, :take_away_evening_starts_at,
 :take_away_evening_ends_at, :id , :commit, :open_noon, :open_evening
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

 form do |f|
    f.inputs do
      f.input :user_id
      f.input :name
      f.input :locality
      f.input :postal_code
      f.input :phone_number
      f.input :latitude
      f.input :longitude
      f.input :picture_file_name
      f.input :picture_content_type
      f.input :picture_file_size
      f.input :picture_updated_at
      f.input :street
      f.input :confirmed
      f.input :iban
      f.input :take_away_noon_starts_at
      f.input :take_away_noon_ends_at
      f.input :take_away_evening_starts_at
      f.input :take_away_evening_ends_at
      f.input :id
      f.input :open_noon
      f.input :open_evening
    end
    f.actions
  end


end
