require 'spec_helper'

module CheckoutKata

  describe Checkout do
    let(:inventory) { Items.inventory }
    let(:checkout) { Checkout.new(inventory) }

    context '.scan' do
      it 'reads an item from its code' do
        item = checkout.scan :FR1

        item.should be_an_instance_of Item
      end

      it 'adds the item into the basket' do
        expect { checkout.scan :FR1 }.to change { checkout.items.count }.by(1)
      end

      it "raises an error on spurious scanner read" do
        expect { checkout.scan :not_existing_item_code }.to raise_error(Checkout::ItemNotRecognized)
      end
    end

    context '.total' do
      it 'calculates the price of the basket' do
        tea_price = inventory[:FR1].price
        coffee_price = inventory[:CF1].price

        checkout.scan(:FR1)
        checkout.total.should == tea_price

        expect { checkout.scan(:FR1) }.to change { checkout.total }.by(tea_price)
        expect { checkout.scan(:CF1) }.to change { checkout.total }.by(coffee_price)
      end

      it 'applies offers if any' do
        checkout = Checkout.new(inventory, [Offer::PayOneForTwo.new(Items::FR1)])

        2.times { checkout.scan :FR1 }

        checkout.total.should == inventory[:FR1].price
      end

      it 'applies all offers present' do
        checkout = Checkout.new(inventory, [Offer::PayOneForTwo.new(Items::FR1),
                                            Offer::BuyMorePayLess.new(item: Items::SR1, quantity: 3, discount: 0.5)])

        2.times { checkout.scan :FR1 }
        4.times { checkout.scan :SR1 }

        checkout.total.should == inventory[:FR1].price + 4 * inventory[:SR1].price - 4 * 0.5
      end

      it 'is zero when not items are present in the basket' do
         checkout.total.should == 0
      end
    end

    context 'Acceptance Tests' do
      let(:checkout) do
        Checkout.new(inventory,
          [Offer::PayOneForTwo.new(Items::FR1),
          Offer::BuyMorePayLess.new(item: Items::SR1, quantity: 3, discount: 0.5)])
      end

      it 'passes the first test example' do
        [:FR1, :SR1, :FR1, :CF1].each { |i| checkout.scan i}

        checkout.total.should == 19.34
      end

      it 'passes the second test example' do
        [:FR1, :FR1].each { |i| checkout.scan i}

        checkout.total.should == 3.11
      end

      it 'passes the third test example' do
        [:SR1, :SR1, :FR1, :SR1].each { |i| checkout.scan i}

        checkout.total.should == 16.61
      end
    end
  end
end