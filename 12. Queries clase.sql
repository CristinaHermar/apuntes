SELECT * FROM actor; #select * todo lo que tengas FROM actor, en vez de asterisco podemos poner las columnas que queramos. alter
/* Esta es otra forma de hacer comentarios*/
select * from actor limit 3; #para traer los 3 primeros

select  first_name, actor_id, last_name, last_update from actor
where first_name like 'm%'; #que empiece con m

select first_name, actor_id, last_name, last_update from actor
where first_name like '%t%'; #que tenga en medio una t

select  first_name, actor_id, last_name, last_update from actor
where first_name like 'm%'
order by first_name desc;
#que empiece con m y ordena de manera descendente alfabéticamente. También pudimos haber puesto asc para que fuera ascendente 

select last_name, count(actor_id) 
from actor group by last_name; #si no le pongo group by me manda todo lo que tiene y se lo asigna al primero que tiene


select last_name as apellido, count(actor_id) 
from actor 
group by last_name; #poner el as apellido es para nombrar la columna o la búsqueda 

select 
	 last_name as apellido, 
     count(actor_id) as conteo_actores
from
	actor 
group by 
	 last_name
having conteo_actores > 1 #para quitar todos los que me aparecen una vez 
order by conteo_actores desc, apellido;

#-----


use sakila; #para llamar a la base
select * from staff limit 1;

/*
select * from staff #la tabla de arriba es la left 
left join address #y la tabla de abajo es right
#me va a traer todo lo de staff y lo que coincida de staff con address
on staff.addres_id = address.address_id /* aquí le indico dónde va a hacer el cruce, de staff selecciona el address_id que es la llave foranea
y de address selecciona addres_id que esla llave primaria de esta tabla */


select staff.first_name, staff.email, address.district from staff
left join address 
on staff.addres_id = address.address_id 
limit 1;

#Podemos renombrar las tablas para hacerlo más sencillo 
select s.first_name, s.email, a.district from staff s 
left join address a 
on s.addres_id = a.address_id 
limit 1;




 




