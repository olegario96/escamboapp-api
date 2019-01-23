require 'rails_helper'

RSpec.describe User, type: :model do
  # Ensure validations before saving user
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cpf) }
  it { should validate_presence_of(:email) }
end
