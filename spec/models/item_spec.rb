require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:product) { FactoryBot.create(:product) }
  let(:user) {FactoryBot.create(:user)}
  let(:client) {FactoryBot.create(:client)}
  let(:reservation) {Reservation.create!(user_id: user.id, client_id:client.id)}
  let(:sell) {Sell.create!(user_id: user.id, client_id:client.id)}
  describe 'validations' do
    context 'when it is valid' do
      it { should validate_presence_of(:product_id) }
      it { should allow_value(110).for(:product_id) }
      it { should validate_numericality_of(:product_id).is_greater_than(0) }
      it { should allow_value('vendido').for(:state) }
      it { should allow_value('reservado').for(:state) }
      it { should allow_value('disponible').for(:state) }
    end

    context 'when not valid' do
      it { should_not allow_value(-1).for(:product_id) }
      it { should_not allow_value('cancelado').for(:state) }
    end

  end

  describe 'relationships' do
    it { should have_many :reservation_details }
    it { should have_many :reservations }
    it { should have_many :sells }
    it { should have_many :sell_details }
    it { should belong_to :product}
  end

  describe '#create_reserve_detail' do
    context 'when the item is reserved and the detail is recorded' do
      let(:item) { product.items.create }
      it { expect(item.create_reserve_detail(reservation.id)).to be_an_instance_of ReservationDetail }
      it { expect{item.create_reserve_detail(reservation.id)}.to change { item.state }.from("disponible").to("reservado") }
      it { expect{item.create_reserve_detail(reservation.id)}.to change(ReservationDetail, :count).by(1)}
    end
  end

  describe '#create_sell_detail' do
    context 'when the item is sold and the detail is recorded' do
      let(:item) { product.items.create }
      it { expect(item.create_sell_detail(sell.id)).to be_an_instance_of SellDetail }
      it { expect{item.create_sell_detail(sell.id)}.to change { item.state }.from("disponible").to("vendido") }
      it { expect{item.create_sell_detail(sell.id)}.to change(SellDetail, :count).by(1)}
    end
  end

end
