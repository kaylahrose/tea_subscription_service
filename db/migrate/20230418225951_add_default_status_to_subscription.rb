class AddDefaultStatusToSubscription < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :status, :integer, using: 'status::integer', default: 0
  end
end
