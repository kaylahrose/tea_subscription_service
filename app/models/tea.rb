class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions

  validates_presence_of :title, :temperature, :brew_time, :description
end
