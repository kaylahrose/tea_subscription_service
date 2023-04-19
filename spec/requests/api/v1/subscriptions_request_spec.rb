require 'rails_helper'

describe 'subscriptions API' do
  it 'create a customers tea subscription' do
    customer = create(:customer)
    tea = create(:tea)
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
    response_body = JSON.parse(response.body, symbolice_names: true)

    expect(response).to be_successful
  end

  it 'cancels a customers tea subscription' do
    customer = create(:customer)
    tea = create(:tea) 
    subscription = Subscription.create(customer_id: customer.id, tea_id: tea.id, price: 10, status: 0, frequency: 'weekly')
    
    patch "/api/v1/subscriptions/#{subscription.id}"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end

  it 'shows all of a customers subscripitons' do
    create_list(:customer, 5)
    create_list(:tea, 5) 
    3.times { Subscription.create(customer_id: Customer.last.id, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') }
    Subscription.create(customer_id: Customer.last.id-1, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') 

    get "/api/v1/customers/#{Customer.last.id}/subscriptions"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end
end