require 'rails_helper'

RSpec.describe 'Search API', type: :request do
  # initialize data
  let!(:user_with_posts) { create_list(:user_with_posts, 10) }
  let(:category) { create(:category) }
  let(:headers) { valid_headers }
  let(:valid_attributtes) {
    {
        productName: "Foo bar",
        description: Faker::Lorem.paragraph,
        price: "#{Random.rand(500)}.#{Random.rand(99)}",
        user_id: user_with_posts.sample.id,
        category_id: category.id
    }
  }

  describe 'POST /search' do
    context 'when the search term exists' do
      before { post '/post', params: valid_attributtes, headers: headers; post '/search', params: {term: "bar"} }
      it 'returns all the records with term' do
        json.each do |post|
          expect(post['productName']).to include("bar")
        end
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the search term does not exists' do
      before { post '/search', params: {term: "bar"} }
      it 'returns empty list' do
        expect(json.length).to be == 0
      end
    end
  end
end