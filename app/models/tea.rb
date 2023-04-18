class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions
end
