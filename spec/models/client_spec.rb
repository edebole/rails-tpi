require 'rails_helper'

# Prefix class methods with a '.'
# Prefix instance methods with a '#'


RSpec.describe Client, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:client) }
    context 'is valid' do
      it { should validate_presence_of(:name) }
      it { should allow_value("alexa foo").for(:name) } 
      it { should_not allow_value("alejo19").for(:name) } 
      it { should validate_presence_of(:cuil_cuit) }
      it { should validate_length_of(:cuil_cuit).is_equal_to(11) }
      it { should validate_uniqueness_of(:cuil_cuit).case_insensitive }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should allow_value("alexa@foo.com").for(:email) } 
      it { should_not allow_value("foo.com").for(:email) } 
    end

    # context 'is invalid' do
    #   it {  }
    # end

  end
  describe 'Relations' do
    it { should have_many :contact_phone }
    it { should belong_to :vat_condition }
    it { should have_many :reservations }
    it { should have_many :sells }
  end

end
