module CheckoutKata
  module Offer
    class BuyMorePayLess
      def initialize(item, quantity, discount)
        @item = item
        @quantity = quantity
        @discount = discount
      end

      def apply(all_items)
        items = all_items.select { |i| i.code == @item.code }
        return [] if  items.size < @quantity

        [OfferItem.new(@discount)]
      end
    end
  end
end
