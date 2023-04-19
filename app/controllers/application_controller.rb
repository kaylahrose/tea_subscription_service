class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_invalid_record(exception)
    render json: ErrorSerializer.record_invalid(exception), status: 400
  end

  def render_not_found(exception)
    render json: ErrorSerializer.record_not_found(exception), status: 404
  end
end
