require 'rails_helper'

RSpec.describe 'Permission API', type: :request do
  # Initialize data
  let!(:user) { create(:user) }
  let!(:permissions) { create_list(:permission, 10) }
  let(:permission)        { permissions.sample }
  let(:permission_id)     { permission.id }
  let(:headers) { valid_headers }

  # Test suite for GET /permission
  describe 'GET /permission' do
    before { get '/permission', params: {}, headers: headers }

    it 'returns permissions' do
      expect(json).not_to be_empty
      expect(json.size).to be > 0
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /permission/:id
  describe 'GET /permission/:id' do
    before { get "/permission/#{permission_id}", params: {}, headers: headers }

    context 'when permission exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns permission' do
        expect(json['id']).to eq(permission_id)
      end
    end

    context 'when permission does not exists' do
      let(:permission_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Permission/)
      end
    end
  end
end