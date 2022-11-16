# Little Esty Shop
![GitHub Contributors](https://img.shields.io/github/contributors/naomiyocum/little-esty-shop)
![GitHub language count](https://img.shields.io/github/languages/count/naomiyocum/little-esty-shop)
![GitHub top language](https://img.shields.io/github/languages/top/naomiyocum/little-esty-shop?color=yellow)

## Table of Contents
* [General Info](#general-info)
* [Learning Goals](#learning-goals)
  * [Solo Project Phases](#solo-project-phases)
* [Technologies](#technologies)
* [Schema Design](#schema-design)

## General Info

"Little Esty Shop Bulk Discounts" was a solo project assigned to us during Week 5 of Mod 2 of 4 in Turing's School of Software & Design. This project builds off of the group project of "Little Esty Shop" that was assigned Week 4 of Mod 2.

Little Esty Shop is a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. The Bulk Discounts extension consisted of adding functionality for merchants to create bulk discounts for their items. A "bulk discount" is a discount based on the quantity of items the customer is buying (e.g. 20% off orders of 10 or more items).

Click [here](https://naomis-little-esty-shop.herokuapp.com/) to head to the live application!

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code
- Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Write model tests that fully cover the data logic of the application
- Write feature tests that fully cover the functionality of the application
### Solo Project Phases
1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Technologies
Project is created with:
* Rails 5.2.6
* Ruby 2.7.4
* PostgreSQL
* SimpleCov
* Git
* Pry
* HTML
* CSS
* ActiveRecord
* Heroku

## Schema Design
Below is our database design with one-to-many and many-to-many relationships.
<img width="912" alt="Screen Shot 2022-11-11 at 10 40 01 AM" src="https://user-images.githubusercontent.com/102825498/201411084-f15bc918-87bd-46a5-ac9b-34e8a1c3ed31.png">
