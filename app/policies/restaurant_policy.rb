class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end


    def update?
      record.user == user
    end
  end
end
