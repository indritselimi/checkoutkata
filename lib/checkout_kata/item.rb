require 'checkout_kata/offer'

module CheckoutKata

  class Item
    attr_reader :code, :name, :price

    def initialize(code, name, price)
      @code = code
      @name = name
      @price = price
    end
  end

  module Items
    class << self
      def all
        [
            [:FR1, 'Fruit Tea', 3.11],
            [:SR1, 'Strawberries', 5],
            [:CF1, 'Coffee', 11.23]
        ].map { |d| Item.new(*d) }
      end

      def inventory
        Hash[*all.map { |i| [i.code, i] }.flatten]
      end
    end

    Items.all.each do |item|
      Items.const_set(item.code, item)
    end
  end

  class OfferItem < Item

    include CheckoutKata::Offer

    def initialize(price, name=default_name, code=:offer)
      super(code, name, price)
    end
  end
end
