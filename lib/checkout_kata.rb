Dir['lib/checkout_kata/**/*.rb'].each { |f| require f.chomp(File.extname(f)).sub(/lib\//, '') }

module CheckoutKata

end
