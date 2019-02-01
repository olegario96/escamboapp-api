require 'rails_helper'

RSpec.describe 'Category API', type: :request do
  # Initialize test data
  let!(:categories) { create_list(:category, 10) }
  let( :category_id) { categories.first.id }

  # Test suite for GET /category
  describe 'GET /category' do
    before { get '/category' }

    it 'returns categories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /category/id
  describe 'GET/category/:id' do
    before { get "/category/#{category_id}" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns category' do
        expect(json['id']).to eq(category_id)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end
end