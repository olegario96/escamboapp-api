require 'rails_helper'

RSpec.describe 'Post Comment API', type: :request do
  # Initialize test data
  let!(:post_with_comments) { create(:post_with_comments) }
  let(:post_id)                   { post_with_comments.id }
  let(:comment_id)                { post_with_comments.comments.sample.id }

  # Test suite for GET /post/:post_id/comment
  describe 'GET /post/:post_id/comment' do
    before { get "/post/#{post_id}/comment" }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all comments' do
        expect(json.size).to be >= 1
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

  # Test suite for GET /post/:post_id/comment/:comment_id
  describe 'GET /post/:post_id/comment/:comment_id' do
    before { get "/post/#{post_id}/comment/#{comment_id}" }

    context 'when comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to be(comment_id)
      end
    end

    context 'when comment does not exists' do
      let(:comment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Comment")
      end
    end
  end
end