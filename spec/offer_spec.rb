module CheckoutKata
  module Offer

    describe 'AnyOffer' do
      class AnyOffer
        def apply(basket)
          OfferItem.new(-0.5)
        end
      end
      context '.apply' do
        it 'applies a list of correction items to the basket' do
          offer = AnyOffer.new
          basket = []

          correction = offer.apply(basket)
          correction.should be_an_instance_of(OfferItem)
        end
      end
    end

    describe PayOneForTwo do
      let(:item) { [Items::FR1] }
      let(:offer) { PayOneForTwo.new(item.first.code) }


      context 'apply' do
        it "no corrections if no item is present in the basket" do
          offer.apply([]).should be_empty
        end

        it "correction if there are two items present in the basket" do
          offer.apply(item * 2).should have(1).item
        end

        it "no corrections if there is only one item present in the basket" do
          offer.apply(item).should have(0).items
        end

        it "one correction when two items are present in the basket" do
          offer.apply(item * 2).should have(1).item
        end

        it "two corrections when four items are present in the basket" do
          offer.apply(item * 4).should have(2).items
        end

        it "5 corrections when 11 items are present in the basket" do
          offer.apply(item * 11).should have(5).items
        end

        it "only on a specific item" do
          PayOneForTwo.new(Items::FR1.code).apply([Items::FR1, Items::CF1]).should be_empty
        end

        it "3 corrections when 11 items are present in total but only 6 match" do
          offer.apply([Items::FR1] * 6 + [Items::CF1] * 5).should have(3).items
        end

        it "a correction that contains a discount with same value of the item's price" do
          offer.apply(item * 2).first.price.should == -item.first.price
        end
      end
    end
  end
end