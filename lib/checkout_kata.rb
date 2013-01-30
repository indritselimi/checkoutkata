Dir['lib/checkout_kata/*.rb'].each { |f| require "checkout_kata/#{File.basename(f, File.extname(f))}" }
Dir['lib/checkout_kata/offer/*.rb'].each { |f| require "checkout_kata/offer/#{File.basename(f, File.extname(f))}" }

module CheckoutKata

end
