class Api::V1::SubscriptionsController < ApplicationController
  def create
    new_sub = Subscription.create(subscription_params) 
    render json: SubscriptionSerializer.new(new_sub)
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :frequency, :price)
  end
end