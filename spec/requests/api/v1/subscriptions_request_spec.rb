require 'rails_helper'

describe 'subscriptions API' do
  describe 'POST /api/v1/customers/:id/teas/:id/subscription' do
    describe 'happy path' do
      it 'create a customers tea subscription' do
        customer = create(:customer)
        tea = create(:tea)
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(response_body[:data][:id]).to be_a String
        expect(response_body[:data][:type]).to be_a String
        expect(response_body[:data][:attributes]).to be_a Hash
      end

      describe 'sad path' do
        it 'responds with error for no/invalid customer' do
          tea = create(:tea)
          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/#{Customer.last.id+1}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response).to_not be_successful
        end
        it 'responds with error for no tea'
        it 'doesnt create subscription with empty params'
      end
    end
  end

  it 'cancels a customers tea subscription' do
    customer = create(:customer)
    tea = create(:tea) 
    subscription = Subscription.create(customer_id: customer.id, tea_id: tea.id, price: 10, status: 0, frequency: 'weekly')
    
    patch "/api/v1/subscriptions/#{subscription.id}"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response_body[:data][:id]).to be_a String
    expect(response_body[:data][:type]).to be_a String
    expect(response_body[:data][:attributes]).to be_a Hash
  end

  it 'shows all of a customers subscripitons' do
    create_list(:customer, 5)
    create_list(:tea, 5) 
    3.times { Subscription.create(customer_id: Customer.last.id, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') }
    Subscription.create(customer_id: Customer.last.id-1, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') 

    get "/api/v1/customers/#{Customer.last.id}/subscriptions"
    response_body = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response_body[:data].first[:id]).to be_a String
    expect(response_body[:data].first[:type]).to be_a String
    expect(response_body[:data].first[:attributes]).to be_a Hash
  end
end