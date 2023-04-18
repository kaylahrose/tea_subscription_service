class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :price, :status, :frequency
end
