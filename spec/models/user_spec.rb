require 'rails_helper'

RSpec.describe User, type: :model do
describe 'validations' do
    subject { FactoryBot.create(:user) }
    context 'when it is valid' do
      it { should validate_presence_of(:username) }
      it { should allow_value("alexaoo").for(:username) } 
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_length_of(:username).is_at_least(4) }
      it { should validate_length_of(:username).is_at_most(25) }

      it { should have_secure_password }
      it { should validate_length_of(:password).is_at_least(4) }
      
      
    end

    context 'when not valid' do
      it { should_not allow_value("ale").for(:username) } 
      it { should_not allow_value("alex nao").for(:username) } 
    end

  end
  describe 'relationship' do
    it { should have_many :sells }
    it { should have_many :reservations }
  end

end
