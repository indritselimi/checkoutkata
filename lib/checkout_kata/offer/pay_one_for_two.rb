module CheckoutKata
  module Offer
    class PayOneForTwo
      def initialize(item)
        @item = item
      end

      def apply(all_items)
        items = all_items.select { |i| i.code == @item.code }
        return [] if items.size < 2
        [OfferItem.new(-items.first.price)] * (items.size / 2)
      end

      def name
        self.class.name.split(/::/).last
      end
    end
  end
end