select m.title
from movie m
where m.director ='Steven Spielberg';

select m.year
from movie m
join rating ra on ra.mid=m.MID
where ra.stars>=4 and ra.STARS<=5
order by m.year asc;

SELECT m.title
from MOVIE m
where m.mid not in(
    select ra.mid
    from rating ra
);

SELECT re.name
from rating ra
join REVIEWER re on re.rid=ra.RID
where ra.RATINGDATE is null
order by re.NAME
;

SELECT re.name,m.title,ra.stars,ra.RATINGDATE
from rating ra
join movie m on m.mid=ra.MID
join REVIEWER re on re.rid =ra.rid
order by re.name,m.title,ra.stars;

--ejercicio 6 de la guia curioso 
SELECT re.name,m.title,r1.STARS
from rating r1
join RATING r2 on r2.RID=r1.RID
join movie m on m.mid=r1.MID
join REVIEWER re on re.rid=r1.RID
where r2.RATINGDATE > r1.RATINGDATE and r2.STARS>r1.STARS;

select m.title ,max(r1.stars)
from movie m
join rating r1 on r1.MID=m.MID
group by m.title
order by m.title,2
;

--8
select m.title,(max(r1.stars)-min(r1.stars)) as dif
from rating r1
join movie m on m.MID=r1.mid
group by m.title
order by dif desc;

--9

select (
    select avg(r1.stars)
    from rating r1
    join movie m on m.mid=r1.mid
    where m.YEAR<1980
)
-
(
    select avg(r1.stars)
    from rating r1
    join movie m on m.mid=r1.mid
    where m.YEAR>1980
) as promedio
from dual;



--repas segunda guia xdxdxd
select distinct re.NAME
from rating ra
join REVIEWER re on re.rid=ra.rid
join movie m on m.mid=ra.mid
where m.title = 'Gone with the Wind';



--2
select re.name,m.title,ra.STARS
from rating ra
join REVIEWER re on re.rid=ra.rid
join movie m on m.mid =ra.mid
where m.director=re.name;


--3
select m.director
from movie m
where m.DIRECTOR is not null
union

select re.name
from REVIEWER re
where re.name is not null
order by 1
;

select distinct m.title
from movie m 
join rating r1 on r1.mid=m.mid
where m.MID not in(
    select m2.mid
    from rating r2
    join MOVIE m2 on m2.mid=r2.mid
    join REVIEWER re on re.rid =r2.rid
    where re.name = 'Chris Jackson'
)
order by m.title
;

--5
select distinct re2.name ,re1.NAME
from rating r1
join rating r2 on r2.MID=r1.MID
join REVIEWER re1 on re1.RID=r1.rid
join reviewer re2 on re2.rid=r2.rid
where re1.RID < re2.RID
order by re2.name
;

--6
select distinct re.name,m.title,r1.stars
from rating r1
join movie m on m.MID=r1.mid
join REVIEWER re on re.rid=r1.rid
where r1.stars in(
select min(r1.stars)
from rating r1)
;


--7
select m.title,avg(r1.stars) as cal
from rating r1 
join movie m on m.mid=r1.mid
group by m.title
order by cal desc;

--8
select re.name
from rating r1
join REVIEWER re on re.rid=r1.rid
group by re.name
having count(r1.rid)>=3
;
--9
select m.title,m.director
from movie m
where m.DIRECTOR in (
    select m2.director
    from movie m2
    group by m2.director
    having count(m2.director) >1
)
order by m.DIRECTOR,m.title;

--10
select m.title,avg(r1.stars) as pr
from rating r1
join movie m on m.mid=r1.mid
group by m.title
having avg(r1.stars) =(
    select max(avg(r2.stars))
    from rating r2
    group by r2.MID
);

--11
select m.title,avg(r1.stars)
from rating r1 
join movie m on m.mid=r1.mid
group by m.title
having avg(r1.stars) =
(
    select min(avg(r2.stars))
    from rating r2
    group by r2.mid
);

--12
select m.director,m.title,max(r1.stars)
from rating r1
join movie m on m.mid=r1.mid
where m.DIRECTOR is not null
group by m.director,m.title
;





--1
select h1.name
from  friend f1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
where h2.name = 'Gabriel';

--2
select h1.name,h1.grade,h2.name,h2.grade
from  likes l1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.id2
where (h1.grade-h2.grade) >=2;

--3
select h1.name,h1.grade,h2.name,h2.grade
from  likes l1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.id2 and h1.id=l1.ID1
where h1.id in(
    select l2.id2
    from likes l2
    where l2.id1=h2.id
)
and 
h2.id in(
    select l3.id2
    from likes l3
    where l3.id1=h1.id
)
and h1.id <h2.id
;

--aletenativa mas limpia 
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM likes l1
JOIN likes l2 ON l1.id1 = l2.id2 AND l1.id2 = l2.id1
JOIN highschooler h1 ON h1.id = l1.id1
JOIN highschooler h2 ON h2.id = l1.id2
WHERE h1.id < h2.id;


--4
select h1.name,h1.grade
from highschooler h1 
where h1.id not in(
    select l1.id1
    from likes l1
)
and 
h1.id not in(
    select l2.id2
    from likes l2
)
order by h1.grade,h1.name;

--5
select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join highschooler h1 on h1.id=l1.ID1
join highschooler h2 on h2.id=l1.ID2
where  exists(
select 1
from likes l2
where l2.id1=l1.ID2 and l2.id2=l1.id1
)
;

--6 tengo que repasar este ejercico mas funcamentos 
select distinct h1.name ,h1.grade
from friend f1
join highschooler h1 on h1.ID=f1.id1
join highschooler h2 on h2.ID=f1.id2
where  exists(
    select 1
    from friend f2
    where f2.id1=h1.id and f2.id2=h2.id
    and h1.grade=h2.grade
)

--5,7,8,9 
repasar que relajo