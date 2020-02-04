require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { FactoryBot.create(:client) }
  let!(:reservation_one) { Reservation.create!(user_id: user.id, client_id: client.id) }
  let(:product1) { FactoryBot.create(:product) }
  let(:product2) { FactoryBot.create(:product) }

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
    it { should have_many :reservation_details }
    it { should have_many :items }
    it { should have_many :products }
    it { should belong_to :user }
    it { should belong_to :client }
    it { should belong_to(:sell).optional }
  end

  describe '.not_sell' do
    let!(:reservation_two) { Reservation.create!(user_id: user.id, client_id: client.id) }

    context 'when the reservation is not sold' do
      it { Reservation.not_sell.should_not be_empty}
      it { expect(Reservation.not_sell.count).to eq 2 }
    end

    context 'when the reservation is sold' do
      let(:sell) { reservation_one.create_sell }
      let!(:mark_sold) { reservation_one.mark_as_sold(sell.id) }
      it { expect(Reservation.not_sell.count).to eq 1 }
    end

  end

  describe '#sell?' do

    context 'when the reservation not is sold' do
      it { expect(reservation_one.sell?).to be_falsey }
    end

    context 'when the reservation is sold' do
      let(:sell) { reservation_one.create_sell }
      let!(:mark_sold) { reservation_one.mark_as_sold(sell.id) }
      it { expect(reservation_one.sell?).to be_truthy }
    end

  end

  describe '#create_sell' do

    context 'when a reservation is sold for the first time' do
      it { expect(reservation_one.sell?).to be_falsey}
      it { expect(reservation_one.create_sell).to be_an_instance_of Sell }
    end

    context 'when a reservation is sold again' do
      let!(:sell) {reservation_one.create_sell}
      let!(:mark_sold) {reservation_one.mark_as_sold(sell.id)}

      it { expect(reservation_one.sell?).to be_truthy}
      it { expect {reservation_one.create_sell}.to raise_error(ExceptionHandler::ReservationSold) }
    end

  end
  
  describe '#reserve_items' do
    context 'when there are enough items available' do
      
    end

    context 'when there is not enough items available' do
      
    end

    context 'when the product does not exist' do

    end
  end

  describe '#sell_items' do
    context 'when the reservation is sold all your items change to sold status' do
      
    end
  end

  describe '#cancel' do
    context 'when the reservation is cancel all your items change to available status' do
      let!(:item1) { product1.items.create }
      let!(:item2) { product2.items.create }
      it { expect(product1.items_available.count ).to eq 1 }
      it { expect(product2.items_available.count ).to eq 1 }
      let(:products) { [ { product_id: product1.id, quantity: '1' }, { product_id: product2.id, quantity: '1' } ] }
      # it { expect(reservation_one.reserve_items(products)).to be_an_instance_of ReservationDetail }
      let!(:detail) {reservation_one.reserve_items(products)}
      it { expect(product1.items_available.count).to eq 0}
      it { expect(product2.items_available.count).to eq 0}
    end
    context 'when the reservation is canceled when it was already sold' do
      let!(:sell) {reservation_one.create_sell}
      let!(:mark_sold) {reservation_one.mark_as_sold(sell.id)}
      it { expect {reservation_one.create_sell}.to raise_error(ExceptionHandler::ReservationSold) }
    end
  end

end




