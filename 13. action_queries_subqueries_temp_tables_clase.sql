use sakila;

CREATE TABLE conte_top_movies
Select 
f.title,
count(r.rental_id) as 'rentas_totales',
count(distinct(c.customer_id)) as 'customer_totales'
from film f
JOIN inventory i
on f.film_id=i.film_id 
left join rental r 
on r.inventory_id=i.inventory_id
left join customer c
on c.customer_id = r.customer_id
group by f.title
order by 2 desc;

select * from conte_top_movies;

SET SQL_SAFE_UPDATES = 0; #se pone esto para salir del modo "seguro" de usuario y poder correr delete
DELETE from conte_top_movies where rentas_totales <30; 

select * from conte_top_movies;

DROP TABLE conte_top_movies;

CREATE table datos_clientes_confidencial #para crear una nueva tabla con los atributos que seleccionemos
Select 
c.customer_id,
DATE_FORMAT(c.create_date,'%M-%Y') 'mes_registro' ,
co.country
from customer c
left join address a on c.address_id = a.address_id
left join city ci on ci.city_id = a.city_id
left join country co on ci.country_id = co.country_id;

Select distinct(country) from datos_clientes_confidencial;

DELETE from datos_clientes_confidencial 
where country not in ('Japan','United States'); #de nuestra nueva tabla borramos la información que no necesitamos. 

Select * from datos_clientes_confidencial
where country = 'Japan';

#queries nesteados un querie dentro de otro queri: 

CREATE TABLE monto_por_peli 
select r_sub.title,SUM(p.amount) as monto_total
from
(Select 
r.rental_id, f.title
from film f 
left join inventory i 
on f.film_id = i.film_id
left join rental r 
on r.inventory_id = i.inventory_id) r_sub #con r_sub estamos nombrando a este query como una tabla temporal.... para poder hacer un query en esta tabla temporal
left join payment p on r_sub.rental_id=p.rental_id
group by 1
order by 2 desc;

drop table monto_por_peli;

Select * from monto_por_peli;

UPDATE monto_por_peli 
SET monto_total = monto_total * 21; #tner cuidado con esta instrucción porque sobreescribimos la información 

Select *, monto_total/21 as USD from monto_por_peli;

INSERT INTO monto_por_peli(title, monto_total)
VALUES('El señor de los Anillos', 329843289); # para insertar una nueva fila. 


select * from monto_por_peli
order by monto_total desc; 























