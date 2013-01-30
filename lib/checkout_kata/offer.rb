Dir['offer/*.rb'].each { |f| require "offer/#{File.basename(f, File.extname(f))}" }

module CheckoutKata
  module Offer
    def default_name
      self.class.name.split(/::/).last
    end
  end
end