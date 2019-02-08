require 'rails_helper'

RSpec.describe Post, type: :model do
  # Ensure that every Post object belongs to a User
  it { should belong_to(:user) }
  # Ensure that every Post object belongs to a Category
  it { should belong_to(:category) }
  # Ensure title and description for product
  it { should validate_presence_of(:productName) }
  it { should validate_presence_of(:description) }
end
