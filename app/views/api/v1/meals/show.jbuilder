json.meal do
  json.id                       @meal.id
  json.name                     @meal.name
  json.picture                  @meal.picture
  json.quantity                 @meal.quantity
  json.stock                    @meal.stock
  json.restaurant_id            @meal.restaurant_id
  json.starting_date            @meal.starting_date
  json.second_date              @meal.second_date
  json.created_at               @meal.created_at
  json.updated_at               @meal.updated_at
  json.active                   @meal.active
  json.price_cents              @meal.price_cents
  json.seated_price             @meal.seated_price
  json.take_away_noon           @meal.take_away_noon
  json.take_away_evening        @meal.take_away_evening
  json.permanent                @meal.permanent


end
