select m.title
from movie m
where m.director ='Steven Spielberg';


select m.year 
from movie m
join rating ra on ra.mid=m.mid
where ra.stars>=4 and ra.STARS<=5
order by m.year asc;

select m.title
from movie m
left join RATING ra on ra.MID=m.MID
where ra.MID is null;

SELECT re.name
from rating ra
join REVIEWER re on re.rid=ra.rid
where ra.RATINGDATE is null;

select re.name,m.title,ra.stars,ra.RATINGDATE
from rating ra
join MOVIE m on m.mid=ra.MID
join REVIEWER re on re.rid=ra.rid
order by re.name, m.title, ra.stars;


--6
select  re.name,m.title,r1.stars,r2.STARS
from rating r1
join rating r2 on r2.MID=r1.MID
join movie m on m.mid=r1.mid
join REVIEWER re on re.rid=r1.rid
where r1.RATINGDATE<r2.RATINGDATE and r1.STARS<r2.STARS;

--7
select m.title,max(ra.stars)
from rating ra 
join MOVIE m on m.mid=ra.mid
group by m.title
order by m.title
;

--8
select m.title,(max(ra.stars)-min(ra.stars)) as diferencia
from RATING ra 
join movie m on m.mid=ra.mid
group by m.title
order by diferencia desc,m.TITLE;

--9
select (
    select avg(ra.stars)
    from rating ra
    join movie m on m.mid=ra.MID
    where m.year >1980
)
-
(
    select avg(ra.stars)
    from rating ra
    join movie m on m.mid=ra.MID
    where m.year <1980
)
as promedio
from dual;


----------------------------------------
select distinct re.name
from rating ra
join REVIEWER re on re.rid =ra.rid
join MOVIE m on m.mid=ra.mid
where m.TITLE = 'Gone with the Wind';


select re.name,m.title
from rating ra
join REVIEWER re on re.rid=ra.rid
join movie m on m.MID=ra.mid
where m.director=re.name;

SELECT m.director
from movie m
union
select 
re.name
from REVIEWER re 
order by director
;


select distinct m.TITLE
from rating ra
join movie m on m.mid=ra.mid
where ra.mid not in(
    select r2.mid
    from rating r2
    join REVIEWER re on re.rid=r2.rid
    where re.NAME='Chris Jackson'
);

--5
select distinct re1.name,re2.name
from rating r1
join rating r2 on r2.mid=r1.mid
join REVIEWER re1 on re1.RID=r1.rid
join REVIEWER re2 on re2.RID=r2.rid
where r1.RID>r2.RID and r1.MID=r2.MID
order by re1.name,re2.name;

select re.name,m.title,r1.stars
from rating r1
join REVIEWER re on re.rid=r1.rid
join movie m on m.mid=r1.mid
where (r1.STARS) in(
    select min(min(r2.STARS))
    from rating r2
    group by r2.mid
);

select m.title,avg(r1.stars) as promedio
from rating r1
join movie m on m.mid=r1.mid
group by m.title
order by promedio desc,m.title;

select re.name
from rating r1
join REVIEWER re on re.rid=r1.rid
group by re.name
having count(r1.stars)>=3;



--9
select m.title,m.director
from movie m
where m.director in(
    select m2.director
    from movie m2
    group by m2.director
    having count(m2.mid)>1
);


--10
select m.title,avg(r1.stars)
from rating r1
join movie m on m.mid=r1.mid
group by m.title
having avg(r1.stars) =(
    select max(avg(r2.stars))
    from rating r2
    group by r2.MID
);

select m.title,avg(r1.stars)
from rating r1
join movie m on m.mid=r1.mid
group by m.title
having avg(r1.stars)=(
    select min(avg(r2.stars))
    from rating r2
    group by r2.MID
);

select m.director,m.title,max(r1.stars) as calificacion
from rating r1
join movie m on m.mid=r1.mid
where m.director is not null
group by m.director,m.title
order by m.DIRECTOR,m.title,calificacion desc
;


select h2.name
from friend f1
join highschooler h1 on h1.ID=f1.ID1
join highschooler h2 on h2.ID=f1.ID2
where h1.name='Gabriel';

select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join highschooler h1 on h1.ID=l1.ID1
join highschooler h2 on h2.ID=l1.ID2
where  (h1.grade-h2.grade)>=2;

select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join likes l2 on l2.id1=l1.id2 and l2.id2=l1.id1
join highschooler h1 on h1.ID=l1.ID1
join highschooler h2 on h2.ID=l2.ID1
where h1.id<h2.id;


--4
select h1.name,h1.grade
from highschooler h1
where h1.id not in(
    select l1.id1
    from likes l1
    union 
    select l2.id2
    from likes l2
);

--5
select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.id2
where h2.id in(
    select l2.id2
    from likes l2
    where l2.id1=h1.id
)
and 
h1.id not in(
select l2.id2
from likes l2
where l2.id1=h2.id
);


SELECT h1.name,h1.grade
from highschooler h1
where not exists(
    select 1
    from friend l1
    join highschooler h2 on h2.id=l1.ID2
    where l1.id1=h1.id and h1.grade <> h2.grade
);

--7
--no entiendo esta 7 ajjaa bueno hay que repasar
/*7. Para cada estudiante A que le guste un estudiante B, pero que no sean amigos, averigua si tienen un
amigo C en común (¡que pueda presentarlos!). Para todos los tríos que coincidan, devuelve el nombre y
el grado de A, B y C.
Resultados esperados:*/
select h1.name,h1.grade,h2.name,h2.grade,h3.name,h3.grade
from likes l1 

join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.ID2
join friend f1 on f1.id1=h2.id
join highschooler h3 on h3.id=f1.ID2
where h2.id in (
    select l2.id2
    from likes l2 
    where l2.id1=h1.id
)
and 
h1.id not in (
    select l2.id2
    from likes l2 
    where l2.id1=h2.id
)
and h2.id<h3.id
;


--8
select (count(h1.id)-count(distinct(h1.name))) as diferencia
from highschooler h1
;

--9
select h1.name ,h1.grade
from likes l1
join highschooler h1 on h1.id=l1.id2
group by h1.name ,h1.grade
having count(l1.id2)>1;