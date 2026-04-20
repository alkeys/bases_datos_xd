/*GUÍA DE CONSULTAS SQL: BASE DE DATOS MOVIES (ORACLE)
Instrucciones: Desarrolle las consultas SQL para los siguientes enunciados utilizando las tablas MOVIE, REVIEWER y
RATING. Utilice el campo stars para las calificaciones y comments para las observaciones o comentarios
NOMBRE COMPLETO:*/

/*1. Críticos de &quot;Gone with the Wind&quot;
Enunciado: Encuentre los nombres de todos los críticos que calificaron la película "Gone with the Wind".
Resultados esperados:
Resultados esperados:
Mike Anderson
Sarah Martinez*/

SELECT DISTINCT r.name
FROM REVIEWER r
JOIN RATING rt ON r.rID = rt.rID
JOIN MOVIE m ON rt.mID = m.mID
WHERE m.title = 'Gone with the Wind';


/*2. Calificaciones por Película y Crítico
Enunciado: Para cualquier calificación donde el crítico sea el mismo que el director de la película,
devuelva el nombre del crítico, el título de la película y el número de estrellas.
Resultados esperados:*/
SELECT r.name AS CriticName, m.title AS MovieTitle, rt.stars
FROM REVIEWER r
JOIN RATING rt ON r.rID = rt.rID
JOIN MOVIE m ON rt.mID = m.mID
WHERE r.name = m.director;


/**
Críticos y Directores (Nombres Comunes)
Enunciado: Devuelva todos los nombres de críticos y directores de la base de datos en una sola lista,
ordenados alfabéticamente.
Resultados esperados el orden importa:*/
SELECT name
FROM (
    SELECT name FROM REVIEWER
    UNION
    SELECT director AS name FROM MOVIE WHERE director IS NOT NULL
)
ORDER BY name;


/*Películas nunca calificadas por &quot;Chris Jackson&quot;
Enunciado: Encuentre los títulos de todas las películas que nunca han sido calificadas por el crítico &quot;Chris
Jackson&quot;.*/
SELECT m.title
FROM MOVIE m
WHERE NOT EXISTS (
    SELECT 1
    FROM RATING rt
    JOIN REVIEWER r ON rt.rID = r.rID
    WHERE rt.mID = m.mID AND r.name = 'Chris Jackson'
);

/*Enunciado: Para todos los pares de críticos que calificaron la misma película, devuelva los nombres de
ambos. Elimine duplicados, no empareje críticos con ellos mismos e incluya cada par solo una vez. Para
cada par, devuelva los nombres en orden alfabético
Resultados esperados el orden importa:*/
SELECT DISTINCT
    LEAST(r1.name, r2.name) AS Critic1,
    GREATEST(r1.name, r2.name) AS Critic2
FROM RATING rt1
JOIN REVIEWER r1 ON rt1.rID = r1.rID
JOIN RATING rt2 ON rt1.mID = rt2.mID
JOIN REVIEWER r2 ON rt2.rID = r2.rID
WHERE r1.rID < r2.rID; 


/*Estadísticas de Calificaciones por Crítico
Enunciado: Para cada calificación que sea la más baja (menor número de estrellas) actualmente en la
base de datos, devuelva el nombre del crítico, el título de la película y el número de estrellas.
Resultados esperados:*/
SELECT r.name AS CriticName, m.title AS MovieTitle, rt.stars
FROM REVIEWER r
JOIN RATING rt ON r.rID = rt.rID
JOIN MOVIE m ON rt.mID = m.mID
WHERE rt.stars = (SELECT MIN(stars) FROM RATING);

/*7. Películas con Directores y Calificaciones
Enunciado: Liste los títulos de las películas y sus calificaciones promedio, de mayor a menor puntuación.
Si dos o más películas tienen el mismo promedio, lístelas en orden alfabético.
Resultados esperados:*/
SELECT m.title, AVG(rt.stars) AS AverageRating
FROM MOVIE m
JOIN RATING rt ON m.mID = rt.mID
GROUP BY m.title
ORDER BY AverageRating DESC, m.title ASC;


/*Enunciado: Encuentre los nombres de todos los críticos que han contribuido con tres o más
calificaciones. (Como desafío adicional, intente escribir la consulta sin usar HAVING o sin usar COUNT)..
Resultados esperados:*/
SELECT r.name AS CriticName
FROM REVIEWER r
JOIN RATING rt ON r.rID = rt.rID
GROUP BY r.name
HAVING COUNT(rt.stars) >= 3;

/*Enunciado: Algunos directores dirigieron más de una película. Para todos estos directores, devuelva los
títulos de todas las películas dirigidas por ellos, junto con el nombre del director. Ordene por nombre del
director, luego por el título de la película. (Como desafío adicional, intente escribir la consulta tanto con
COUNT como sin COUNT).
Resultados esperados:*/
select m.title, m.director  
from MOVIE m
where m.director in (
    select director 
    from MOVIE 
    group by director 
    having count(*) > 1
)
order by m.director, m.title;

/*Títulos de Películas con promedio más alto
Enunciado: Encuentre la(s) película(s) con el promedio de calificación más alto. Devuelva el título(s) de
la película y su promedio de calificación.
Resultados esperados:
Snow
White*/
SELECT m.title, AVG(rt.stars) AS AverageRating
FROM MOVIE m
JOIN RATING rt ON m.mID = rt.mID
GROUP BY m.title
HAVING AVG(rt.stars) = (SELECT MAX(AvgStars) FROM (
    SELECT AVG(stars) AS AvgStars
    FROM RATING
    GROUP BY mID
));


/*Enunciado: Encuentre la(s) película(s) con el promedio de calificación más bajo. Devuelva el título(s) de
la película y su promedio de calificación. (Sugerencia: puede pensar en ello como encontrar primero el
promedio de calificación más bajo y luego elegir la(s) película(s) que tengan ese promedio específico).
Resultados esperados:*/
SELECT m.title, AVG(rt.stars) AS AverageRating
FROM MOVIE m
JOIN RATING rt ON m.mID = rt.mID
GROUP BY m.title
HAVING AVG(rt.stars) = (SELECT MIN(AvgStars) FROM (
    SELECT AVG(stars) AS AvgStars
    FROM RATING
    GROUP BY mID
));

/*Enunciado: Para cada director, devuelva su nombre junto con el título(s) de la(s) película(s) que dirigió y
que recibió la calificación más alta entre todas sus películas, incluyendo el valor de dicha calificación.
Ignore aquellas películas cuyo director sea nulo (NULL).
Resultados esperados:*/
SELECT m.director, m.title, AVG(rt.stars) AS AverageRating
FROM MOVIE m
JOIN RATING rt ON m.mID = rt.mID
WHERE m.director IS NOT NULL
GROUP BY m.director, m.title
HAVING AVG(rt.stars) = (SELECT MAX(AvgStars) FROM (
    SELECT AVG(stars) AS AvgStars
    FROM MOVIE m2
    JOIN RATING rt2 ON m2.mID = rt2.mID
    WHERE m2.director = m.director
    GROUP BY m2.title
));
