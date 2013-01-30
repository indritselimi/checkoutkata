module CheckoutKata
  module Offer
    class PayOneForTwo
      def initialize(item_code)
        @item_code = item_code
      end

      def apply(all_items)
        items = all_items.select { |i| i.code == @item_code }
        return [] if items.size < 2
        [OfferItem.new(-items.first.price)] * (items.size / 2)
      end

      def name
        self.class.name.split(/::/).last
      end
    end
  end
end