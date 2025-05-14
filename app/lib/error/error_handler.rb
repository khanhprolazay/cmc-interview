module Error
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      self.class_eval do
        rescue_from Exception do |e|
          case e
          when BaseException then respond(e.error, e.status, e.message)
          else respond(:internal_server_error, :internal_server_error, e.message)
          end
        end
      end
    end

    private
    def respond(_error, _status, _message)
      @error = _error
      @message = _message
      render "application/error", formats: :json, status: _status
    end
  end
end
