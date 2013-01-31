module CheckoutKata
  class Checkout
    attr_reader :items

    def initialize(inventory, offers=[])
      @inventory = inventory
      @offers = offers

      @items = []
    end

    def scan(code)
      current = @inventory[code]
      fail ItemNotRecognized.new("Code: '#{code}' not in inventory.") unless current
      @items << current
      current
    end

    def total
      (@items + offer_items).collect(&:price).inject(0, &:+)
    end

    ItemNotRecognized = Class.new ArgumentError

    private

    def offer_items
      @offers.collect { |o| o.apply(@items) }.flatten
    end
  end
end