require 'rails_helper'

RSpec.describe Tea do
  describe 'relationships' do
    it {should have_many :subscriptions}
    it {should have_many(:customers).through(:subscriptions)}
  end
end