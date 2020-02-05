require 'rails_helper'

RSpec.describe Sell, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:client) {FactoryBot.create(:client)}
  describe 'validations' do
    context 'when it is valid' do
      it { should validate_presence_of(:client_id) }
      it { should validate_numericality_of(:client_id).is_greater_than(0) }
      it { should validate_presence_of(:user_id) }
      it { should validate_numericality_of(:user_id).is_greater_than(0) }
    end

    context 'when not valid' do
      it { should_not allow_value(-1).for(:user_id) }
      it { should_not allow_value(-1).for(:client_id) }
    end

  end

  describe 'relationships' do
    it { should have_many :sell_details }
    it { should have_many :items }
    it { should have_many :products }
    it { should belong_to :user }
    it { should belong_to :client }
    it { should belong_to(:reservation).optional }
  end

  describe '.all_for_user' do
    context 'when the user does not make any sales' do
      let(:user_two) {FactoryBot.create(:user)}
      let!(:sell) {Sell.create!(user_id: user_two.id, client_id:client.id)}
      it { expect(Sell.all_for_user(user.id)).to be_empty}
    end

    context 'when the user makes a sale' do
      let!(:sell) {Sell.create!(user_id: user.id, client_id:client.id)}
      it { expect(Sell.all_for_user(user.id)).to_not be_empty}
      it { expect(Sell.all_for_user(user.id).count).to eq 1 }
    end

  end
  describe '#sell_items' do
    let(:product1) {FactoryBot.create(:product)}
    let(:product2) {FactoryBot.create(:product)}
    let(:sell) { Sell.create!(user_id:user.id, client_id: client.id) }
    let(:products) {[ { product_id: product1.id, quantity: '1' }, { product_id: product2.id, quantity: '1' } ]}
    context 'when there are enough items available' do
      let!(:item1) { product1.items.create }
      let!(:item2) { product2.items.create }
      let(:detail) { sell.sell_items(products) }
      it { expect{detail}.to change(SellDetail, :count).by(2)}
    end

    context 'when there is not enough items available' do
      let(:detail) { sell.sell_items(products) }
      it { expect{detail}.to change(SellDetail, :count).by(0)}
    end

  end

end
