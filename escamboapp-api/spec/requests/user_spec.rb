require 'rails_helper'

RSpec.describe 'User API', type: :request do
  # Initialize data
  let!(:user) { create(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_headers_) { valid_headers }
  let(:valid_attributes) do
    {
      name: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      cpf: Faker::CPF.numeric
    }
  end

  let!(:user_with_posts) { create(:user_with_posts) }
  let(:user_id) { user.id }
  let(:post_id) { user_with_posts.posts.sample.id }

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Cpf can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  # Test suite for GET /user
  describe 'GET /user' do
    # make HTTP get request before each example
    before { get '/user', params: {}, headers: valid_headers_ }

    it 'returns user' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /user/:id
  describe 'GET /user/:id' do
    before { get "/user/#{user_id}", params: {}, headers: valid_headers_ }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end


    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /user
  describe 'POST /user' do
    let(:valid_attributes) {
      {
        name: Faker::Name.first_name,
        cpf: Faker::CPF.numeric,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    }

    context 'when the request is valid' do
      before { post '/user', params: valid_attributes }

      it 'creates a user' do
        expect(json['id']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/user', params: { name: 'Gustavo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Password can't be blank, Cpf can't be blank, Email can't be blank/)
      end
    end
  end

  # Test suite for PUT /user/:id
  describe 'PUT /user/:id' do
    let(:valid_attributes) { { name: 'Gustavo' } }

    context 'when the record exists' do
      before { put "/user/#{user_id}", params: valid_attributes, headers: valid_headers_}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /user/:id
  describe 'DELETE /user/:id' do
    before { delete "/user/#{user_id}", params: {}, headers: valid_headers_ }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end