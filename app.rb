require "./lib/shop.rb"

shop = Shop.instance

shop.load_products()

begin
  # read input.txt file
  File.readlines('data/input.txt').each do |line|
    shop.process_order(line)
  end
rescue Errno::ENOENT, Errno::EACCES
  puts "No valid input.txt file in /data folder. Please try again."
ensure
  shop.create_invoice()
  shop.print_invoice()
  exit
end