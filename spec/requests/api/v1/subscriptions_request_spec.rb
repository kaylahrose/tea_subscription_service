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
    end

    describe 'sad path' do
      it 'responds with error for no/invalid customer' do
        customer = create(:customer)
        tea = create(:tea)
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customers/#{Customer.last.id+1}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response_body[:error].first[:title]).to eq("Validation failed: Customer must exist")
        expect(response_body[:error].first[:status]).to eq('400')
      end

      it 'responds with error for no tea' do 
        customer = create(:customer)
        tea = create(:tea)
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customers/#{customer.id}/teas/#{tea.id+1}/subscriptions", headers: headers, params: JSON.generate({frequency: "monthly", price: 10})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response_body[:error].first[:title]).to eq("Validation failed: Tea must exist")
        expect(response_body[:error].first[:status]).to eq('400') 
      end

      it 'doesnt create subscription with empty params' do
        customer = create(:customer)
        tea = create(:tea)
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({price: 10})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response_body[:error].first[:title]).to eq("Validation failed: Frequency can't be blank")
        expect(response_body[:error].first[:status]).to eq('400')  

        post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({frequency: 'monthly'})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response_body[:error].first[:title]).to eq("Validation failed: Price can't be blank")
        expect(response_body[:error].first[:status]).to eq('400')  

        post "/api/v1/customers/#{customer.id}/teas/#{tea.id}/subscriptions", headers: headers, params: JSON.generate({})
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response_body[:error].first[:title]).to eq("Validation failed: Price can't be blank, Frequency can't be blank")
        expect(response_body[:error].first[:status]).to eq('400')  
      end
    end
  end

  describe 'PATCH /api/v1/subscriptions/:id' do
    describe 'happy path' do
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
    end
    
    describe 'sad path' do
      it 'returns 404 for bad id' do
        customer = create(:customer)
        tea = create(:tea) 
        subscription = Subscription.create(customer_id: customer.id, tea_id: tea.id, price: 10, status: 0, frequency: 'weekly')
        
        patch "/api/v1/subscriptions/#{Subscription.last.id+1}"
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect(response_body[:error].first[:title]).to eq("Couldn't find Subscription with 'id'=#{Subscription.last.id+1}")
        expect(response_body[:error].first[:status]).to eq('404')  
      end
    end
  end

  describe 'GET /api/v1/customers/:id/subscriptions' do
    describe 'happy path' do
      it 'shows all of a customers subscripitons' do
        create_list(:customer, 5)
        create_list(:tea, 5) 
        3.times { Subscription.create(customer_id: Customer.last.id, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') }
        Subscription.create(customer_id: Customer.last.id-1, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') 

        get "/api/v1/customers/#{Customer.last.id}/subscriptions"
        response_body = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response_body[:data].count).to eq(3)
        expect(response_body[:data].first[:id]).to be_a String
        expect(response_body[:data].first[:type]).to be_a String
        expect(response_body[:data].first[:attributes]).to be_a Hash
      end
    end

    describe 'sad path' do
      it 'returns not found for bad id' do
        create_list(:customer, 5)
        create_list(:tea, 5) 
        3.times { Subscription.create(customer_id: Customer.last.id, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') }
        Subscription.create(customer_id: Customer.last.id-1, tea_id: Tea.last.id, price: 10, status: 0, frequency: 'weekly') 

        get "/api/v1/customers/#{Customer.last.id+1}/subscriptions"
        response_body = JSON.parse(response.body, symbolize_names: true)
      
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect(response_body[:error].first[:title]).to eq("Couldn't find Customer with 'id'=#{Customer.last.id+1}")
        expect(response_body[:error].first[:status]).to eq('404')  
      end
    end
  end
end