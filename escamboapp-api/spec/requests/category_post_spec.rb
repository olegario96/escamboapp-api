require 'rails_helper'

RSpec.describe 'User Post API', type: :request do
  # Initialize the test data
  let!(:category) { create(:category_with_posts) }
  let(:category_id) { category.id }
  let(:post_id) { category.posts.sample.id }

  # Test suite for GET /category/:category_id/post
  describe 'GET /category/:category_id/post' do
    before { get "/category/#{category_id}/post" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all posts' do
        expect(json.size).to be >= 1
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Category")
      end
    end
  end

  # Test suite for GET /category/:category_id/post/:post_id
  describe 'GET /category/:category_id/post/:post_id' do
    before { get "/category/#{category_id}/post/#{post_id}" }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['id']).to be(post_id)
      end
    end

    context 'when post doest not exists' do
      let(:post_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Post")
      end
    end
  end
end