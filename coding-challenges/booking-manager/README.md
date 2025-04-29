# About

Provides a library to handle booking requests for guest visits and
determine who's allowed to visit based on pre-stablished rules.

# Design

In order to achieve the desired functionality, a simple strategy class structure
has been devised like in the diagram below.

The `BookingManager` class is instanciated and then custom strategies are added to
it with `#add_strategy`.

By calling `#evaluate` with a list of bookings, the `BookingManager` class parses
each request and delegates the decision to each strategy.
The strategy then determines whether the booking should be rejected or not.

This allows for future extension with new business rules.


```
          ,------------------------.           
          |BookingManager          |           
          |------------------------|           
          |+ evaluate(booking_list)|           
          |+ add_strategy(strategy)|           
          `------------------------'           
                       |                       
                       |                       
            ,-------------------.              
            |Strategy           |              
            |-------------------|              
            |+ evaluate(booking)|              
            `-------------------'              
                                               
,-------------------.  ,----------------------.
|HoursPerDayStrategy|  |VisitorsPerDayStrategy|
|-------------------|  |----------------------|
|+ evaluate(booking)|  |+ evaluate(booking)   |
`-------------------'  `----------------------'
```

# Assumptions

- Booking requests are handled in order, regardless of the booking date.

# Caveats

- Due to lack of clarification, when handling the max hours rule, it's not checked whether the visitor will exceed the limit with a single visit. This could be extended to include the range in the checks.
- Due to time constraints, common errors haven't been handled and tested for, but I've added a `FIXME` note where handling is applicable.


# Requirements

* Ruby 3.2.2

# Testing

To run the rspec suite of tests simply run `bundle exec rspec`.

```
bundle install
bundle exec rspec
```
