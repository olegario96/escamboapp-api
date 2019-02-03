require 'rails_helper'

RSpec.describe 'Comment API', type: :request do
  # Initialize data
  let!(:comments)  { create_list(:comment, 10) }
  let!(:post_)     { create(:post) }
  let!(:user)      { create(:user) }
  let(:comment_id)        { comments.sample.id }
  let(:headers)           { valid_headers }

  # Test suite for GET /comment
  describe 'GET /comment' do
    before { get '/comment', params: {}, headers: headers }

    it 'returns all comements' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /comment/:id
  describe 'GET /comment/:id' do
    before { get "/comment/#{comment_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the comment' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(comment_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:comment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for POST /comment/:id
  describe 'POST /comment' do
    let(:valid_attributes) {
      {
          title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph,
          rating: Faker::Number.between(1, 5),
          user_id: user.id,
          post_id: post_.id
      }
    }

    context 'when the request is valid' do
      before { post '/comment', params: valid_attributes, headers: headers }

      it 'creates a commment' do
        expect(json['title']).to eq(valid_attributes[:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/comment', params: { title: 'Foo' }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: User must exist, Post must exist, Description can't be blank, Rating can't be blank/)
      end
    end
  end

  # Test suite for PUT /comment/:id
  describe 'PUT /comment/:id' do
    let(:valid_attributes) { { title: Faker::Lorem.sentence } }

    context 'when the record exists' do
      before { put "/comment/#{comment_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /comment/:id
  describe 'DELETE /comment/:id' do
    before { delete "/comment/#{comment_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end