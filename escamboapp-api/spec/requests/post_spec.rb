require 'rails_helper'

RSpec.describe 'Post API' do
  # Initialize the test data
  let!(:user) { create(:user_with_posts) }
  let(:user_id) { user.id }
  let(:post_id) { user.posts.sample.id }
  let(:category_id) { user.posts.sample.category_id }

  # Test suite for GET /user/:user_id/posts
  describe 'GET /user/:user_id/post' do
    before { get "/user/#{user_id}/post" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all posts' do
        expect(json.size).to be > 0
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /category/:category_id/post
  # describe 'GET /category/:category_id/post' do
  #   before { get "/category/#{category_id}/post" }
  #
  #   context 'when category exists' do
  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end
  #
  #     it 'returns all posts' do
  #       expect(json.size).to be > 0
  #     end
  #   end
  # end
end