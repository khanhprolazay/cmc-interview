module Auth
  module Authenticate extend ActiveSupport::Concern
    included do
        before_action :authenticate
    end

    def authenticate
        iam_service = Container.get(:iam)
        @iam_user = iam_service.validate(request)
        return render_unauthorized if @iam_user.nil?

        @user = User.eager_load(:purchased_assets).find_by(iam_id: @iam_user["sub"])
        @user = iam_service.save_user(@iam_user) if not @user
    end

    private
    def render_unauthorized
      render json: "Bad credentials", status: :unauthorized
    end
  end
end
