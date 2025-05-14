module Error
  module CommonError
    class TransactionError < BaseException
        def initialize
          super(:transaction_error, 500, "Invalid or incomplete")
        end
    end

    class NotFoundError < BaseException
      def initialize
        super(:not_found_error, 404, "Not Found")
      end
    end

    class InvalidParamsError < BaseException
      def initialize
        super(:invalid_params_error, 400, "Invalid Params Error")
      end
    end

    class BadRequestError < BaseException
      def initialize
        super(:bad_request, 400, "Bad Request")
      end
    end

    class ForbiddenError < BaseException
      def initialize
        super(:forbidden_error, 403, "Forbidden")
      end
    end

    class Unauthorized < BaseException
      def initialize
        super(:unauthorized, 400, "Unauthorized")
      end
    end
  end
end
