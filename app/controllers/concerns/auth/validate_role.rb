module Auth
  module ValidateRole extend ActiveSupport::Concern
    included do
      before_action :validate_role
    end

    class_methods do
      def require_role(role:, actions:)
        actions.each do |action|
          action_sym = action.to_sym

          if map[action_sym].nil?
            map[action_sym] = []
          end

          # Save role
          map[action_sym] << role
        end
      end

      def map
        @map ||= {}
      end
    end

    def validate_role
        action_required_roles = self.class.map[action_name.to_sym]
        unless action_required_roles.nil?
          iam_service = Container.get(:iam)
          is_user_have_needed_role = action_required_roles.any? { |role| iam_service.is_role_exist?(@iam_user, role) }
          render_forbidden if not is_user_have_needed_role
        end
    end

    private
    def render_forbidden
      render json: "Forbidden", status: :forbidden
    end
  end
end
