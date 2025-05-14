module Api
  class UsersController < ApplicationController
      def me
        render "users/one"
      end
  end
end
