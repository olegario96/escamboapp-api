require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # Ensure User model has 1:m relationship with User model
  it { should have_many(:posts) }

  # Ensure validations before saving user
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
