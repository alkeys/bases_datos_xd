--1
select re.name
from REVIEWER re 
where exists(
    select 1
    from rating ra
    where ra.rid=re.rid and ra.RATINGDATE is null
);
-------------------------------------------
--1
select re.name
from rating ra
join REVIEWER re on re.RID=ra.RID
where ra.RATINGDATE is null;
--2
SELECT re.name,m.title,ra.stars,ra.RATINGDATE
from rating ra
join movie m on m.mid=ra.MID
join REVIEWER re on re.rid=ra.RId
order by re.NAME,m.title,ra.STARS;

--3
select m.title
from movie m
where not exists(
    select 1
    from rating ra
    where m.mid=ra.MID
);

/*Para cada película que tenga al menos una calificación, 
encuentre el título y la calificación más alta
 (máximo de estrellas) que ha recibido. Ordene alfabéticamente por título.*/
 select m.title,max(r1.stars)
 from rating r1
 join MOVIE m on m.mid=r1.MID
 group by m.title
 order by m.title;

 /*Enunciado: Para todos los casos donde el mismo crítico calificó la misma
  película dos veces y le dio una calificación más alta la segunda vez, 
  devuelva el nombre del crítico y el título de la película.*/

  select distinct re.name,m.title
  from rating r1
  join rating r2 on r1.mid=r2.MID
  join REVIEWER re on re.rid=r1.RID
  join movie m on m.MID=r1.mid
  where r1.RATINGDATE<>r2.RATINGDATE and r1.STARS>r2.STARS;


/*Encuentra los nombres de los críticos y los títulos de las películas a las que les dieron exactamente 3 estrellas.*/
select re.name,m.title
from rating ra
join movie m on m.mid=ra.MID
join REVIEWER re on re.RID=ra.RID
where ra.STARS=3;

/*Encuentra los nombres de los 
críticos que evaluaron alguna película estrenada en el año 1939. Asegúrate de que no salgan nombres repetidos.*/
select distinct re.name
from rating ra
join REVIEWER re on re.rid=ra.RID
join movie m on m.mid=ra.mid
where m.year=1939;

/*Queremos saber cuántas críticas recibió cada director. Muestra el nombre
 del director y la cantidad de calificaciones (estrellas) 
 que han recibido sus películas en total. Ignora a los directores nulos.*/*

 select m.director,count(ra.STARS)
 from rating ra
 join movie m on m.mid=ra.MID
 where m.director is not null
 group by m.director;


 /**Para cada película, calcule la diferencia entre su calificación más alta y la más baja. 
 Muestre el título y la diferencia, ordenando de mayor a menor diferencia y luego alfabéticamente por título.*/
 select m.title,(max(ra.stars)-min(ra.stars)) as diferencia
 from rating ra
 join movie m on m.mid=ra.MID
 group by m.title
 order by m.title
 ;

 /*Queremos ver a los críticos indecisos. Encuentra los nombres de los críticos que calificaron la misma película dos veces, 
 pero le dieron estrellas diferentes (no importa si fue mayor o menor, solo que sean distintas).*/
 select distinct re.name 
 from rating r1
 join rating r2 on r2.rid=r1.rid and r2.mid=r1.mid
 join REVIEWER re on re.rid=r1.rid 
 where r1.stars<>r2.stars;



 /*Encuentra los títulos
  de las películas cuyo año de estreno sea mayor
   al año de estreno promedio de todas las películas de la base de datos.*/
select m.title
from movie m
where m.year >(
    select avg(m2.year)
    from movie m2
);


/*Encuentra los nombres de los críticos que han calificado 2 o más películas distintas.*/
select re.name
from rating r1
join REVIEWER re on re.rid=r1.rid
group by re.name
having count(distinct(r1.stars))>1;

/*Tu revancha! Encuentra el nombre del crítico y el título 
de la película en los casos donde el crítico evaluó la misma película dos veces,
 y le dio una calificación mayor en la segunda fecha.*/
 select re.name,m.title
 from rating r1
 join rating r2 on r1.rid=r2.rid and r1.mid =r2.mid
 join REVIEWER re on re.rid=r1.rid
 join movie m on m.mid=r1.mid
 where r1.RATINGDATE<>r2.RATINGDATE and r1.stars>r2.stars;

 /*Encuentra pares de críticos (Nombre 1, Nombre 2) que hayan calificado la misma película
  Asegúrate de no emparejar a un crítico consigo mismo y de no mostrar pares duplicados 
  (Si sale Ana-Beto, que no salga Beto-Ana).*/
  select distinct re1.name,re2.name
  from rating r1
  join rating r2 on r2.mid=r1.mid
  join REVIEWER re1 on re1.rid=r1.rid
  join REVIEWER re2 on re2.rid=r2.rid
  where re1.rid < re2.rid;


