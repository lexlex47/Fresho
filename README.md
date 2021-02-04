# Fresho

It is a code test for Fresho.

## Task

A fresh food supplier sells product items to customers in packs. The bigger the pack, the cheaper the cost per item. Note that the system has determined the optimal packs to fill the order.

### TODO

1.  Generate an invoice for the order
2.  The exact method & format of input/output is not important
3.  Write code you will be happy to put into production
4.  TDD
5.  Make sure your code handles the given example

### Dependencies

    Ruby => 2.7.2p137 (2020-10-01 revision 5445e04352) [x64-mingw32]
    Rspec

### Installation

Clone the repo and then execute:

    $ bundle install

### Run

Before running, make sure you have input.txt file locate in /data folder.

To run execute:

    $ ruby app.rb

The system will output result on console directly.

### Test

To run rspec test execute:

    $ rspec

***

## Design

### First thought

_Language_
Ruby
_Store packs details_
The packs data are load from a txt/xml file.
_Load Customer Order_
Use file reader to load customer order data, from a txt/xml file.
_Print Invoice_
Use the console to print invoice, because want to keep thing simple.
_System workflow_
1.  start system from an entry point, like a Main class
2.  load the default packs details directly after create a main instance
3.  load customer order txt file line by line, and create relate instances
4.  pass all instances to a handler class to caculate best practice
5.  pass the solution to invoice instance
6.  print out the invoice to console
_Instance and Classes_
1.  the app class, which is this system entry point
2.  shop class
3.  product class       [1 name, multiple packs]
4.  pack class          [1 pack quantity, 1 pack price]
5.  line-product class  [1 product, 1 total purchase quantity, 1 sub total]
6.  invoice class       [multiple line-products]
_Methods_
1.  shop class          load_default_packs_details()
                        initial_product_instances()
                        read_customer_order()
                        create_line-products(products)
2.  product class       add_packs_to_product()
3.  pack class
4.  line-product class  find_best_practice()
                        get_sub_total()
5.  invoice class       print()
