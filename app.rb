require "./lib/shop.rb"

shop = Shop.instance

begin
  shop.load_products()
  # read input.txt file
  File.readlines('data/test.txt').each do |line|
    shop.process_order(line)
  end
  shop.create_invoice()
rescue Errno::ENOENT, Errno::EACCES
  puts "No valid input.txt file in /data folder. Please try again."
ensure
  exit
end