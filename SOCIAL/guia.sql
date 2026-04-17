/*GUÍA DE CONSULTAS SQL: BASE DE DATOS SOCIAL (ORACLE)
Instrucciones: Desarrolle las consultas SQL para los siguientes enunciados utilizando las tablas Highschooler, Friend
y Likes.*/


/*1. Encuentra los nombres de todos los estudiantes que 
son amigos de alguien llamado Gabriel
Resultados esperados:*/
SELECT  distinct h.name FROM Highschooler h 
JOIN Friend f ON h.ID = f.ID1 OR h.ID = f.ID2
JOIN Highschooler h2 ON (f.ID1 = h2.ID OR f.ID2
    = h2.ID) AND h2.name = 'Gabriel'
    WHERE h.name != 'Gabriel';

/*2. Para cada estudiante que le guste alguien 2 o más grados menor que ellos, devuelve el nombre y
grado de ese estudiante, y el nombre y grado del estudiante que le gusta..
Resultados esperados:
Your Query Result:
John 12 Hale
y
10*/
SELECT h1.name, h1.grade, h2.name, h2.grade FROM Highschooler h1
JOIN Likes l ON h1.ID = l.ID1
JOIN Highschooler h2 ON l.ID2 = h2.ID
WHERE h1.grade - h2.grade >= 2;


/*3. Para cada estudiante que tiene una relación de &quot;me gusta&quot; mutua (A le gusta B y B le gusta A),
devuelve el nombre y el grado de ambos estudiantes. Incluye cada pareja solo una vez y muestra los
nombres en orden alfabético.
Cassandr
a

9 Gabriel 9

Jessica 11 Kyle 12*/
SELECT h1.name, h1.grade, h2.name, h2.grade FROM Highschooler h1
JOIN Likes l1 ON h1.ID = l1.ID1
JOIN Likes l2 ON l1.ID2 = l2.ID1 AND l2.ID2
    = h1.ID
JOIN Highschooler h2 ON l1.ID2 = h2.ID
WHERE h1.name < h2.name; -- Esto asegura que cada pareja se muestre solo una vez y en orden alfabético.



/*Encuentra a todos los estudiantes que no gustan de nadie y de los que nadie gusta. Devuelve sus
nombres y grados. Ordena los resultados por grado y luego por nombre dentro de cada grado.
Resultados esperados:*/
SELECT name, grade FROM Highschooler
WHERE ID NOT IN (SELECT ID1 FROM Likes)
AND ID NOT IN (SELECT ID2 FROM Likes)
ORDER BY grade, name;

/*Para cada pareja de estudiantes A y B donde a A le gusta B, pero a B no le gusta A, devuelve el
nombre y grado de A y B
Resultados:
Alexis 11 Kris 10
Austin 11 Jorda
n
12

Brittan
y
10 Kris 10

John 12 Haley 10*/
SELECT h1.name, h1.grade, h2.name, h2.grade FROM Highschooler h1
JOIN Likes l ON h1.ID = l.ID1
JOIN Highschooler h2 ON l.ID2 = h2.ID
WHERE NOT EXISTS (
    SELECT 1 FROM Likes l2
    WHERE l2.ID1 = h2.ID AND l2.ID2 = h1.ID
);


/*6. Encuentra a aquellos estudiantes que son amigos solo 
de personas de su mismo grado. Devuelve sus
nombres y grados. Ordena los resultados por grado y luego por nombre.
Resultados esperados:*/
SELECT name, grade FROM Highschooler h
WHERE NOT EXISTS (
    SELECT 1 FROM Friend f
    JOIN Highschooler h2 ON (f.ID1 = h2.ID OR f.ID2 = h2.ID)
    WHERE (f.ID1 = h.ID OR f.ID2 = h.ID) AND h2.grade != h.grade
)
ORDER BY grade, name;


/*7. Para cada estudiante A que le guste un estudiante B, pero que no sean amigos, averigua si tienen un
amigo C en común (¡que pueda presentarlos!). Para todos los tríos que coincidan, devuelve el nombre y
el grado de A, B y C.
Resultados esperados:*/
SELECT 
    H1.name AS Estudiante_A, H1.grade AS Grado_A,
    H2.name AS Estudiante_B, H2.grade AS Grado_B,
    H3.name AS Amigo_C, H3.grade AS Grado_C
FROM Highschooler H1
JOIN Likes L ON H1.ID = L.ID1
JOIN Highschooler H2 ON L.ID2 = H2.ID
JOIN Friend F1 ON H1.ID = F1.ID1
JOIN Friend F2 ON H2.ID = F2.ID1
JOIN Highschooler H3 ON F1.ID2 = H3.ID
WHERE F1.ID2 = F2.ID2 -- C es amigo de A y también de B (el amigo en común)
  AND H1.ID <> H2.ID  -- No son la misma persona
  AND NOT EXISTS (    -- Pero A y B NO son amigos directos
    SELECT 1 FROM Friend 
    WHERE (ID1 = H1.ID AND ID2 = H2.ID)
  );

  /*8. Calcula la diferencia entre el número de estudiantes en Highscholler y el número de nombres de
estudiantes distintos*/
SELECT 
    (SELECT COUNT(*) FROM Highschooler) - 
    (SELECT COUNT(DISTINCT name) FROM Highschooler) 
AS Diferencia
FROM DUAL;

/*Encuentra el nombre y grado de todos los estudiantes que tienen más de un &quot;me gusta&quot;
Resultados esperados:*/
SELECT H.name, H.grade
FROM Highschooler H
JOIN Likes L ON H.ID = L.ID2
GROUP BY H.ID, H.name, H.grade
HAVING COUNT(*) > 1;