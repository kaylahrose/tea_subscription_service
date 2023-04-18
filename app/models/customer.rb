class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :teas, through: :subscriptions

  validates_presence_of :first_name, :last_name, :email, :street_address
  validates_uniqueness_of :email
end
