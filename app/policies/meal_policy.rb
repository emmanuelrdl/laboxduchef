class MealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

 def new?
    user.restaurant_owner == true

 end

 def create?
   user.restaurants.first.id = record.restaurant.id
 end

 def update?
    record.restaurant.user == user
 end

 def edit?
    record.restaurant.user == user
 end

 def destroy?
    record.restaurant.user == user
 end
end
