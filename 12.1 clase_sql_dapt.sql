/*Selecccionando todo lo de actor*/
select * from actor limit 1;

Select first_name,actor_id,last_name, last_update
from actor
where first_name like 'm%' 
order by first_name asc;

/*COnteo actores para viaje a laas vegas*/
Select 
	last_name apellido, 
	count(actor_id) conteo_actores
from 
	actor 
group by 
	last_name
having count(actor_id)>1
order by conteo_actores desc, apellido asc;

use sakila;

select 
	s.first_name,
	s.email,
	a.district
/*La tabla de arriba es la left*/
from 
	staff s
/*La tabla de abajo es la right*/
left join 
	address a
		on s.address_id = a.address_id
limit 1;

/*Recepcion dinero de nuestros cajeros*/
Select 
	s.first_name, 
	s.last_name, 
	sum(p.amount) total_paid 
from 
	staff s 
join 
	payment p
	on s.staff_id=p.staff_id
where
	month(p.payment_date)=8
	and year(p.payment_date)=2005
group by 1,2;

Select 
	c.first_name,
	c.last_name,
	c.email,
	c3.country 
from 
	customer c
left join 
	address a 
	on c.address_id = a.address_id
left join 
	city c2
	on c2.city_id=a.city_id
left join 
	country c3
	on c3.country_id = c2.country_id;
    
/*Lo que necesito es de cada categoría de pelicula, su revenue (amount)*/    
Select
	c.name,
	sum(IFNULL(p.amount,0)) total_amount
from 
	category c
left join 
	film_category fc
	on c.category_id = fc.category_id
left join 
	film f 
	on f.film_id = fc.film_id
left join 
	inventory i
	on i.film_id = f.film_id
left join 
	rental r 
	on r.inventory_id = i.inventory_id
left join 
	payment p 
	on p.rental_id = r.rental_id
group by 
	c.name
order by 
	total_amount asc;
