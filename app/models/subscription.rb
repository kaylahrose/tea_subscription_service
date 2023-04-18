class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer
end