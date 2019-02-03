require 'rails_helper'

RSpec.describe 'User Post API', type: :request do
  # Initialize the test data
  let!(:user) { create(:user_with_posts) }
  let(:user_id) { user.id }
  let(:post_id) { user.posts.sample.id }
  let(:headers) { valid_headers }

  # Test suite for GET /user/:user_id/post
  describe 'GET /user/:user_id/post' do
    before { get "/user/#{user_id}/post", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the posts' do
        expect(json.size).to be >= 1
      end
    end

    context 'when user does not exists' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find User")
      end
    end
  end

  # Test suite for GET /user/:user_id/post/:post_id
  describe 'GET /user/:user_id/post/:post_id' do
    before { get "/user/#{user_id}/post/#{post_id}", params: {}, headers: headers }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns post' do
        expect(json['id']).to eq(post_id)
      end
    end

    context 'when post does not exists' do
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