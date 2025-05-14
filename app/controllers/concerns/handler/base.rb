module Handler
  class Base
    def initialize(user)
      @user = user
    end

    def current_user
      @user
    end

    def handle
      raise "Not implemented"
    end
  end
end
