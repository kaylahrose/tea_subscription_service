class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    subs = Subscription.where(customer_id: params[:customer_id])
    render json: SubscriptionSerializer.new(subs)
  end
end