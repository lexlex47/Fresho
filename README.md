# Fresho

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/8535a674f84142cb9ed46856feec0990)](https://www.codacy.com/gh/lexlex47/Fresho/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=lexlex47/Fresho&amp;utm_campaign=Badge_Grade)
[![Build Status](https://travis-ci.org/lexlex47/Fresho.svg?branch=main)](https://travis-ci.org/lexlex47/Fresho)
[![Maintainability](https://api.codeclimate.com/v1/badges/3c0ad7ecc1d811d8baf6/maintainability)](https://codeclimate.com/github/lexlex47/Fresho/maintainability)
[![codecov](https://codecov.io/gh/lexlex47/Fresho/branch/main/graph/badge.svg?token=DYMT55KF51)](https://codecov.io/gh/lexlex47/Fresho)

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
    Bundler => 2.1.4
    Gem => 3.1.4
    Rspec

### Installation

Clone the repo from https://github.com/lexlex47/Fresho

and then execute:

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

- Language

Ruby

- Store packs details

The packs data are load from a txt/xml file.

- Load Customer Order

Use file reader to load customer order data, from a txt/xml file.

- Print Invoice

Use the console to print invoice, because want to keep thing simple.

- System workflow

1.  start system from an entry point, like a Main class
2.  load the default packs details directly after create a main instance
3.  load customer order txt file line by line, and create relate instances
4.  pass all instances to a handler class to caculate best practice
5.  pass the solution to invoice instance
6.  print out the invoice to console

- Instance and Classes

1.  the app class, which is this system entry point
2.  shop class
3.  product class[1 name, multiple packs]
4.  pack class[1 pack quantity, 1 pack price]
5.  line-product class[1 product, 1 total purchase quantity, 1 sub total]
6.  invoice class[multiple line-products]

- Methods

shop class
```
{ 
    load_default_packs_details()
    initial_product_instances()
    read_customer_order()
    create_line-products(products)
}
```
product class
```
{
    add_packs_to_product()
}
```
pack class
line-product class
```
{ 
    find_best_practice()
    get_sub_total()
}
```
invoice class
```
{ 
    print() 
}
```

***

### Patterns

- Singleton

Set the Shop class to be a singleton. Because of Shop instance will and always be only one in the system. It will not be created except in the main class.

- Factory Method

Because system has multiple types of products, it may increase in the future. And each product may have different attributes, therefore it is necessary to have a Creator class to generate different products.
So add a Creator class 
```
{ 
    create_product(type)
    create_line-product(product) 
}
```
and modify the Shop class to
```
{
    load_default_packs_details()
    creator.create_product(type)
    read_customer_order()
    creator.create_line-product(product)
}
```
It will make system loose coupling and easily maintenance after.

***

### Find best solution

There will be three basic occasions.

- First
```
Line-product.quantity = 10
pack[min-quantity = 15]
```
There is no usable packs here, so there will be a remainder 10.

- Second
```
Line-product.quantity = 10
pack[min-quantity = 5]
```
10 / 5 = 2...0
There are some packs that can be divisible without remainder.

- Third
```
Line-product.quantity = 10
pack[min-quantity = 3]
```
10 / 3 = 3...1
Although there are packs that can be used, they cannot be divisible and still have a remainder.

So the system should try its best to find the second case as the best solution.

***

Here the system sets a default_unit_price. As can be known from the task description, the smaller the packs, the more expensive the unit price, so the default_unit_price algorithm I set is to use the smallest existing pack unit price, which will be like:
```
pack1[quantity = 3, price = 6]
pack2[quantity = 5, price = 8]
```
so the default_unit_price will be 6 / 3 = $2.

***

- For the First case, now the system can directly get the best result is:
    
    remainder * default_unit_price(1 pack)

- Here is another example for the Second case:
```
Line-product.quantity = 14
pack[min-quantity = 2, price = 9.95]
pack[min-quantity = 5, price = 16.95]
pack[min-quantity = 8, price = 24.95]
```
There will have multiple combinations without remainder:

    solution1[7 * 2pack = 14]
    solution2[2 * 5pack + 2 * 2pack = 14]
    solution3[1 * 8pack + 3 * 2pack = 14]

The first step is to choose the one with the least total packs, so solution1 is excluded.

At the beginning, I think the next step is to find the lowest total price,

    solution2[sub_total = 53.80]
    solution3[sub_total = 54.80]

so the solution should be 2 * 5pack + 2 * 2pack, however it is not right.
After thinking for a while, I found that solution needs to use the bigger pack as much as possible. So the system should sort packs array by quantity, so the bigger pack will appear in the last solution, the required solution will be the last one: solution3.

- For the Third case, it can be seen as a loop of the above two cases.
```
result_list = []
while(remainder)
    solution = caculate_method(remainder)
    result_list << solution
    break if solution.remainder == 0
    break if solution.remainder < all_packs_quantity
    remainder = solution.remainder
end
```
for instance,
```
Line-product.quantity = 10
pack[min-quantity = 8]
```
so the solution should be 1 * 8pack + 2 * 1pack

***

## Implement Code

- Initial repo

- Add Rspec

- Define application entry point and Shop class

set the Shop class to be Singleton
```
require 'singleton'
include Singleton
```
(https://github.com/lexlex47/Fresho/commit/2776138cc660e4d45f3641834cd21509109a04d2)

- Implement Factory Method

Define Creator class, Product class, Pack class and first Watermelon class.
I made adjustments here. The default_product_data and default_packs_data are no longer read from the file, but directly hardcode to the Shop class.
Use Shop.load_products to tell Creator to create Watermelon instance with packs.
(https://github.com/lexlex47/Fresho/commit/965b109db588a112be59fcd2d28886edfcc9ae35)

- Implement line_product

Define Line_Item class and Watermelon_line_item class.
(https://github.com/lexlex47/Fresho/commit/6babb6d2edd54f380fabad7350a4d801fe6d7327)

- Add file reader to Shop class

Implement a method to read order_details from a txt file. The file only have one order which is 10 Watermelons.
If there is a product instance already exist, only add quantity to this product's current_quantity.
(https://github.com/lexlex47/Fresho/commit/f8fb0c8cad14c20da963afc5d41c169b32923d69)

- Implement a find remainder method in Line_Item class.

Use divmod() to get an array
```
    dividends.each do |dividend|
        result = remainder.divmod(dividend)
    end
    remainder = result[1]
    return if remainder == 0
```
(https://github.com/lexlex47/Fresho/commit/d889eb7219ea44983475b93f011044ca33b647f9)

- Implement a caculate default_unit_price method.

(https://github.com/lexlex47/Fresho/commit/79909cc8e0a70482e4a746b4167f9fdec8cfd886)

- Define a Selection class and refactoring find_best_solution method

The solution will have at least one selection instance.
```
Selection[quantity, pack_quantity, total_price]
```
For instance, if a solution is like 1 * 8pack + 3 * 2pack, it will like
```
solution[
            selection1[1, 8, 24.95],
            selection2[3, 2, 19.90]
        ]
```
(https://github.com/lexlex47/Fresho/commit/2efd9f07b065007df56b3363349b9ba83ce56459)

- Define Invoice class and implement the print method.

(https://github.com/lexlex47/Fresho/commit/c536fea3878d00bee1f5cd1159d5e50ff9c9f6c5)

- Define the Pineapple and Rockmelon class

(https://github.com/lexlex47/Fresho/commit/09629f8cfb95779aed33f3d952d4ec1a8bda1622)

- Update the invoice print format

(https://github.com/lexlex47/Fresho/commit/b818cea3b3e86c0773a762b9f9856ac41387b352)

- Refactoring methods and add some edges

Like can not receive negative number, or input should be numeric....
```
def is_numerical(arg)
    return nil if (arg.to_s.match(/[^-?\d+]/)) || (arg == '')
    arg.to_i
end
```
(https://github.com/lexlex47/Fresho/commit/2e4b90645f5e661c64f8e6057e7a89aa72ead1f4)

- Update Readme

***

## Something can be refactoring...

- The default_packs and default_products should load from txt or xml somewhere else, instead of hardcode.

- Add some commands...

- Add exceptions and handlers.

- Update the bundler?


