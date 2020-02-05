require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:product) }
    context 'when it is valid' do
      it { should validate_presence_of(:unique_code) }
      it { should allow_value("143ABC111").for(:unique_code) }
      it { should validate_uniqueness_of(:unique_code) }
      it { should validate_length_of(:unique_code).is_equal_to(9) }

      it { should validate_presence_of(:description) }
      it { should validate_length_of(:description).is_at_most(200) }
      
      it { should validate_presence_of(:detail) }
      it { should validate_length_of(:detail).is_at_most(1000) }

      it { should validate_presence_of(:unit_price) }
      it { should validate_numericality_of(:unit_price).is_greater_than(0) }
      
    end

    context 'when not valid' do
      it { should_not allow_value("143ABC11D").for(:unique_code) }
      it { should_not allow_value(0).for(:unit_price) }
      it { should_not allow_value(-2).for(:unit_price) }
    end

  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe '.in_stock' do

    context 'when there is no stock for any product' do
      it { expect(Product.in_stock).to be_empty } 
    end
    context 'when there is stock for some product' do
      let(:product) { FactoryBot.create(:product) }
      let!(:item) { product.items.create }
      it { expect(Product.in_stock).to_not be_empty }
    end

  end

  describe '.scarce' do

    context 'when there is no stock for any product' do
      it { expect(Product.scarce).to be_empty }
    end
    context 'when stock is between 1 and 5' do
      let(:product) { FactoryBot.create(:product) }
      let!(:item) { 3.times { product.items.create} }
      it { expect(Product.scarce).to_not be_empty }
    end
    context 'when the stock is greather that 5' do
      let(:product) { FactoryBot.create(:product) }
      let!(:item) { 6.times { product.items.create} }
      it { expect(Product.scarce).to be_empty }
    end
  end

  describe '.all_limit' do

    context 'when the product has no stock' do
      let!(:product) { FactoryBot.create(:product) }
      it { expect(Product.all_limit).to_not be_empty } 
    end
    context 'when the product has stock' do
      let(:product) { FactoryBot.create(:product) }
      let!(:item) { product.items.create }
      it { expect(Product.all_limit).to_not be_empty }
    end

  end

  describe '#items_available' do
    let(:product) { FactoryBot.create(:product) }
    context 'when this has items availables' do
      let!(:item) { 3.times { product.items.create } }
      it { expect(product.items_available).to_not be_empty }
      it { expect(product.items_available.count).to eq 3 }
      it { expect(product.items_available.first.state).to eq 'disponible'}
    end
    context 'when this has no items availables' do
      it { expect(product.items_available).to be_empty }
    end
    context 'when this has all your items reserved' do
      let(:item) { product.items.create }
      let!(:item_reserverd) { item.reserve! }
      it { expect(product.items_available).to be_empty }
      it { expect(product.items_available.count).to eq 0 }
    end
    context 'when this has all your items sold' do
      let(:item) { product.items.create }
      let(:item_reserverd) { item.sell! }
      it { expect{item}.to change {product.items_available.count}.from(0).to(1) }
      it { expect{item_reserverd}.to change { item.state }.from("disponible").to("vendido") }
      it { expect(product.items_available.count).to eq 0 }
    end
  end
end
