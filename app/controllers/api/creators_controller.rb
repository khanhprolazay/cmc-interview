module Api
  class CreatorsController < ApplicationController
        require_role role: Role::ADMIN, actions: [ :index ]

        def index
            handler = Handler::Admin::ListCreatorsHandler.new(@user)
            @models = handler.handle()
            render json: @models
        end
  end
end
