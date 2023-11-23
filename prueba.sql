--el postgres no me andaba y para no perder tiempo lo hice en SqliteBrowser

--Crear una vista (VIEW) que muestre de cada alquiler, su duración, el nombre completo del cliente, el nombre de la película y la fecha de alquiler.
CREATE VIEW alquiler as
SELECT rental_duration as duracion,c.first_name as nombre,c.last_name as apellido,f.title as nombrePelicula,rental_date as fecha FROM 
film f JOIN inventory i USING (film_id)
JOIN rental r USING(inventory_id)
JOIN customer c USING (customer_id)

--Elegir un actor o actriz que no esté en el sistema y agregarlo, junto con al menos tres películas en las que haya participado. 
INSERT INTO "actor"(actor_id,first_name,last_name) values (1500,'Cillian','Murphy');
INSERT INTO "film"(film_id,title,release_year,length,rating,language_id,last_update) values (15000,'Batman inicia',2005,140,'R',1,"");
INSERT INTO "film"(film_id,title,release_year,length,rating,language_id,last_update) values (15001,'El origen',2010,148,'R',1,"");
INSERT INTO "film"(film_id,title,release_year,length,rating,language_id,last_update) values (15002,'Un lugar en silencio',2020,97,'R',1,"");
INSERT INTO "film_actor"(actor_id,film_id,last_update) values (1500,15000,"");
INSERT INTO "film_actor"(actor_id,film_id,last_update) values (1500,15001,"");
INSERT INTO "film_actor"(actor_id,film_id,last_update) values (1500,15002,"");

--Por cuestiones de privacidad se decidió borrar todos los emails de los clientes, escriba una consulta en SQL para lograr esto.
UPDATE customer set email = NULL 

--Borrar todos las categorías que tengan menos de 50 películas (borrar o modificar todo lo necesario para poder borrar estas categorías)
DELETE FROM category

--En la tabla de empleados, se quieren resetear los usuarios y claves. Poner el apellido como nombre de usuario y "1234" como clave.
UPDATE staff SET username = last_name, password = 1234

--Borrar todos los clientes que no tengan alquileres(rentals)
DELETE FROM customer WHERE customer_id NOT IN 
(SELECT DISTINCT customer_id FROM rental)

--Agregar a todos los empleados como clientes del sistema. 
INSERT INTO customer (customer_id, first_name, last_name, email, address_id, store_id,create_date, last_update) 
VALUES (25000,(SELECT first_name nombre FROM staff limit 1),(SELECT last_name apellido FROM staff limit 1),
(SELECT email FROM staff limit 1),(SELECT address_id FROM staff WHERE staff_id = 1),(1),"2006-02-14 22:04:36.000", "");

INSERT INTO customer(customer_id, first_name, last_name, email, address_id, store_id, create_date, last_update)
VALUES (25001,(SELECT first_name FROM staff limit 1 offset 1),(SELECT last_name FROM staff limit 1 offset 1),
(SELECT email FROM staff limit 1 offset 1),(SELECT address_id FROM staff WHERE staff_id = 2),(1),"2006-02-14 22:04:36.000", "");