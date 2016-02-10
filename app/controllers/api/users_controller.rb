module Api
  class UsersController < Api::BaseController

    private

      def artist_params
        params.require(:user).permit(:first_name)
      end

      def query_params
        params.permit(:first_name)
      end

  end
end
