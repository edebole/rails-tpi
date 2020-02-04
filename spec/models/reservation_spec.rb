require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { FactoryBot.create(:client) }
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
    let!(:reservation_one) { Reservation.create!(user_id: user.id, client_id: client.id) }
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
      let(:reservation_one) { Reservation.create!(user_id: user.id, client_id: client.id) }
      it { expect(reservation_one.sell?).to eq false }
    end

    context 'when the reservation is sold' do
      let(:reservation_one) { Reservation.create!(user_id: user.id, client_id: client.id) }
      let(:sell) { reservation_one.create_sell }
      let!(:mark_sold) { reservation_one.mark_as_sold(sell.id) }
      it { expect(reservation_one.sell?).to raise_error ExceptionHandler::ReservationSold }
    end

  end

  describe '#create_sell' do
    let(:reservation_one) { Reservation.create!(user_id: user.id, client_id: client.id) }

    context 'when a reservation is sold for the first time' do
      it { expect(reservation_one.sell?).to eq false }

    end

    context 'when a reservation is sold again' do
      let(:sell) { reservation_one.create_sell }
      let!(:mark_sold) { reservation_one.mark_as_sold(sell.id) }
      it { expect(reservation_one.sell?).to raise_error ExceptionHandler::ReservationSold }
    end

  end
  
  describe '#reserve_items' do
    skip
  end

  describe '#mark_as_sold' do
    skip
  end
  
  describe '#sell_items' do
    skip
  end
end




