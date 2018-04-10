module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::ParameterMissing, with: :rescue400
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private

  def rescue400(exception)
    @exception = exception
    render 'errors/bad_request', status: :bad_request
  end

  def rescue404(exception)
    @exception = exception
    render 'errors/not_found', status: :not_found
  end

  def rescue500(exception)
    @exception = exception
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
