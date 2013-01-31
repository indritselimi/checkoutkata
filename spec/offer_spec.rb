module CheckoutKata
  module Offer

    shared_examples_for 'AnyOffer' do
      class AnyOffer
        def apply(basket)
          [OfferItem.new(0.5)]
        end
      end

      context '.apply' do
        it 'a list of correction items' do
          offer = AnyOffer.new
          basket = []

          correction = offer.apply(basket)
          correction.first.should be_an_instance_of(OfferItem)
        end
      end
    end

    describe PayOneForTwo do
      let(:item) { Items::FR1 }
      let(:another_item) { Items::CF1 }
      let(:offer) { PayOneForTwo.new(item) }

      context '.apply' do
        it_behaves_like "AnyOffer"

        it "no corrections if no item is present in the basket" do
          offer.apply([]).should be_empty
        end

        it "correction if there are two items present in the basket" do
          offer.apply([item] * 2).should have(1).item
        end

        it "no corrections if there is only one item present in the basket" do
          offer.apply([item]).should have(0).items
        end

        it "one correction when two items are present in the basket" do
          offer.apply([item] * 2).should have(1).item
        end

        it "two corrections when four items are present in the basket" do
          offer.apply([item] * 4).should have(2).items
        end

        it "5 corrections when 11 items are present in the basket" do
          offer.apply([item] * 11).should have(5).items
        end

        it "only on a specific item" do
          offer.apply([item, another_item]).should be_empty
        end

        it "3 corrections when 11 items are present in total but only 6 match" do
          offer.apply([item] * 6 + [another_item] * 5).should have(3).items
        end

        it "a correction that contains a discount with same value of the item's price" do
          offer.apply([item] * 2).first.price.should == -item.price
        end
      end
    end

    describe BuyMorePayLess do
      let(:item) { Items::FR1 }
      let(:another_item) { Items::CF1 }
      let(:discount) { -0.5 }
      let(:offer) { BuyMorePayLess.new(item, 2, discount) }

      context '.apply' do
        it_behaves_like "AnyOffer"

        it 'a correction when more than n items are present in the basket' do
          offer.apply([item]).should be_empty
          offer.apply([item] * 2).should_not be_empty
        end

        it "only on a specific item" do
          offer.apply([item, another_item]).should be_empty
        end

        it "a correction that contains a fixed discount for each specific item" do
          offer.apply([item, item, another_item]).first.price.should == discount
        end
      end
    end
  end
end