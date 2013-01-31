module CheckoutKata
  module Offer
    def default_name
      self.class.name.split(/::/).last
    end
  end
end