require 'rails_helper'

describe 'subscriptions API' do
  it 'create a customers tea subscription' do
    customer = create(:customer)
    tea = create(:tea)
    headers = { "CONTENT_TYPE" => "application/json" }

    post "api/v1/customers/#{customer.id}/teas/#{tea.id}/", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
    response_body = JSON.parse(response.body, symbolice_names: true)

    expect(response).to be_successful
  end
end