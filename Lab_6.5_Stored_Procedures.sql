## Lab | Stored procedures

use sakila;

#1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure.

DELIMITER //
create procedure spcategory_action()
begin
	select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = "Action"
	group by first_name, last_name, email;
end //
DELIMITER ; 
drop procedure spcategory_action;

call spcategory_action();

#2. Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.
DELIMITER //
create procedure spcategory(in category varchar(50))
begin
	select first_name, last_name, email
	from customer
	join rental on customer.customer_id = rental.customer_id
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
	join film_category on film_category.film_id = film.film_id
	join category on category.category_id = film_category.category_id
	where category.name = category
	group by first_name, last_name, email;
end //
DELIMITER ; 
drop procedure spcategory;
call spcategory("Children");


#3. Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.
DELIMITER //
create procedure movies_by_category(in category varchar(50))
begin
	select count(film_id) as number_of_movies
	from film_category a
	join category b on a.category_id = b.category_id
	where b.name = category;
end //
DELIMITER ; 
drop procedure movies_by_category;
call movies_by_category("Action");

