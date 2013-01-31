module CheckoutKata
  module Offer
    class BuyMorePayLess
      def initialize(options)
        @item = options[:item]
        @quantity = options[:quantity]
        @discount = options[:discount]
      end

      def apply(all_items)
        items = all_items.select { |i| i.code == @item.code }
        return [] if  items.size < @quantity

        [OfferItem.new(-@discount)] * items.size
      end
    end
  end
end
