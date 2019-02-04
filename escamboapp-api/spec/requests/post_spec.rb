require 'rails_helper'

RSpec.describe 'Post API', type: :request do
  # initialize data
  let!(:user_with_posts) { create_list(:user_with_posts, 10) }
  let(:category) { create(:category) }
  let(:headers) { valid_headers }
  let(:post_id) { user_with_posts.sample.posts.sample.id }

  # Test suite for GET /post
  describe 'GET /post' do
    # make HTTP request before each example
    before { get '/post', params: {}, headers: headers }

    it 'returns post' do
      expect(json).not_to be_empty
      expect(json.size).to be > 0
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /post/:id
  describe 'GET /post/:id' do
    before { get "/post/#{post_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /post
  describe 'POST /post' do
    let(:valid_attributtes) {
      {
        productName: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        price: "#{Random.rand(500)}.#{Random.rand(99)}",
        user_id: user_with_posts.sample.id,
        category_id: category.id
      }
    }

    context 'when the request is valid' do
      before { post '/post', params: valid_attributtes, headers: headers }

      it 'creates a post' do
        expect(json['id']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/post', params: { productName: 'Foo' }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed/)
      end
    end
  end

  # Test suite for PUT /post/:id
  describe 'PUT /post/:id' do
    let(:valid_attributes) { { productName: 'Bar' } }

    context 'when the record exists' do
      before { put "/post/#{post_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /post/:id
  describe 'DELETE /post/:id' do
    before { delete "/post/#{post_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end