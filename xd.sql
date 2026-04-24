--1
SELECT m.title,m.year
from movie m
where m.year <1980;
--2
select m.title
from movie m 
where m.DIRECTOR is null;

--3
SELECT distinct re.name
from rating ra 
JOIN REVIEWER re on re.RID =ra.RID
where ra.STARS=3;

--4
select m.title,m.year
from movie m
order by m.year,m.TITLE;

--5
select re.name,ra.STARS
from REVIEWER re
join rating ra on ra.RID=re.RID
where ra.RATINGDATE is not null and ra.stars>3;

--6
SELECT m.director,COUNT(m.mid)
from MOVIE m
WHERE m.director is not null
GROUP by  m.director
;
--7
select max(ra.stars)
from movie m
join rating ra on ra.mid=m.mid
where m.title = 'Gone with the Wind'
group by m.mid;

--8
select re.name
from rating ra 
join REVIEWER re on re.RID=ra.RID
having count(ra.rid)>=3
group by re.name;
--9
select m.title,avg(r1.stars) as promedio
FROM RATING r1 
join movie m on m.mid=r1.MID
group by m.TITLE
order by promedio desc
;
--10
SELECT m.title
from rating ra
join movie m on m.mid=ra.MID
where m.MID in (
  select ra2.mid
  from rating ra2 
  where ra2.stars=5
);


--11
select m.title,m.year
from movie m 
where m.year> (
  select max(total)
  from (select avg(m2.year) as total
  from movie m2
  )
);

--12
select m.TITLE
from movie m
where m.MID not in (
  select ra.mid
  from rating ra
  );

--13
select m.title,max(ra.stars)
from rating ra
join movie m on m.mid= ra.mid
group by m.title
;

--14
select distinct re.name
from rating ra 
join REVIEWER re on re.rid =ra.rid
where ra.RATINGDATE is null;


--15
select distinct r1.RID ,r1.mid
from RATING r1
join rating r2 on r2.RID=r1.RID
where r1.mid=r2.MId and r1.RATINGDATE != r2.RATINGDATE;

--16
select re.name
from rating r1
JOIN rating r2 on r2.RID = r1.RID
join REVIEWER re on re.rid =r1.rid
where r1.MID =r2.MID and r1.STARS< r2.STARS;

--17
select m.title,(max(r1.stars)-min(r1.stars)) as dif
from rating r1
join movie m on m.mid=r1.mid
group by m.title
order by dif desc
;

--18
select distinct re.name
from rating ra
join REVIEWER re on re.rid =ra.rid
join movie m on m.mid=ra.mid
where m.title ='Gone with the Wind';

--19
select m.director as  nombre
from movie m
union
select re.NAME 
from REVIEWER re
order by nombre
;


--20
select m.title
from movie m 
where m.mid not in (
  select ra2.mid
  from REVIEWER re 
  join rating ra2 on ra2.rid=re.rid
  where re.NAME = 'Chris Jackson'
);

--21
select re.name
from rating ra
join movie m on m.mid = ra.mid
join reviewer re on re.rid= ra.RID
where m.DIRECTOR = re.name;

--22
select distinct re2.NAME,re1.NAME
from rating r1
join rating r2 on r2.mid=r1.mid
join REVIEWER re1 on re1.RID=r1.RID
join REVIEWER re2 on re2.RID = r2.RID
where r1.RID<r2.RID;

--23
select re.name,m.title ,ra.stars
from rating ra
join movie m on m.mid=ra.mid
join REVIEWER re on re.rid =ra.rid
where ra.stars =(
  select min(r1.stars)
  from rating r1
)
;


--24
select re.name,m.title,avg(ra.stars) as promedio
from rating ra
join movie m on m.mid=ra.mid
join REVIEWER re on re.RID=ra.rid
group by re.name,m.title
order by promedio desc,m.title asc;

--25
select m.title,re.name
from rating ra
join movie m on m.mid=ra.mid
join reviewer re on re.rid =ra.RID
having count(re.name)>1
group by m.title,re.name;



--26
select h1.name
from friend f1
join highschooler h1 on h1.id = f1.ID1
join HIGHSCHOOLER h2 on h2.id =f1.ID2
where h2.name='Gabriel';

--27
/*Para cada estudiante que le guste alguien 2 
o más grados menor que ellos, devuelve el nombre 
y grado de ese estudiante, y el nombre y grado del 
estudiante que le gusta.*/
select h1.name,h1.grade,h2.name,h2.grade
from likes f1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
where (h1.grade-h2.grade) >=2;


--28
select h1.name,h2.name
from likes l
join highschooler h1 on h1.id=l.id1
join highschooler h2 on h2.id=l.id2
where h1.id<h2.id;
--29
select h1.name,h1.grade
from highschooler h1 
where h1.id not in(
  select l1.id1
  from likes l1
  union
  select l2.id2
  from likes l2
);


--30
select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.id2
where h1.id not in(
  select l2.id2
  FROM likes l2 
  where l2.id1 = h2.id
);

--31
select h1.name,h1.grade,h2.name,h2.grade
from FRIEND f1
join highschooler h1 on h1.id=f1.ID1
join highschooler h2 on h2.ID=f1.ID2
where h1.grade = h2.grade
order by h1.grade,h1.name;

--32 esta si no le entiendo mucho need repasar mas 
select distinct h1.name,h2.name
from likes l1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.ID2
JOIN Friend f1 ON l1.ID1 = f1.ID1
JOIN Friend f2 ON l1.ID2 = f2.ID1 AND f1.ID2 = f2.ID2
JOIN Highschooler h3 ON f1.ID2 = h3.ID
WHERE NOT EXISTS (
  SELECT 1 FROM Friend 
  WHERE (ID1 = l1.ID1 AND ID2 = l1.ID2)
);

--33
select (count(h1.name)-count(distinct(h1.name))) as diferencia
from highschooler h1;

--34
select h1.name,h1.grade
from likes l1
join highschooler h1 on h1.ID =l1.ID2
having count(l1.id2)>1
group by h1.name,h1.grade;

--35 no si esta buena xd
select h1.name,count(f1.id2)
from friend f1
join highschooler h1 on h1.id = f1.id2
having count(f1.id2) =(
  select max(count(f2.id2))
  from friend f2
  group by f2.ID1
)
group by h1.name;


--36
select h1.name,count(l1.id1)
from likes l1
join highschooler h1 on h1.id=l1.ID2
having count(l1.id2) =(
  select max(count(l2.id2))
  from likes l2 
  group by l2.id2
)
group by h1.name;

--37
select distinct re.name
from rating ra
join reviewer re on re.rid=ra.rid
join reviewer re2 on re2.rid=re.rid
where ra.rid =re.rid  and ra.rid =re2.rid
 ;

 --38
 select m.director
 from movie m
 where m.year >1980;

 --39
 select distinct h1.name,h1.grade
 from likes l1
 join highschooler h1 on h1.id=l1.id1
 join highschooler h2 on h2.id=l1.id2
 join friend f1 on f1.ID1 =h1.id 
 join friend f2 on f2.ID2 !=f1.id1 
 where h1.grade >h2.grade
 ;

 --40

 select re.name
 from rating ra 
 join reviewer re on re.rid=ra.rid
 having avg(ra.stars)>(
  select avg(ra2.stars)
  from rating ra2
 )
 group by  re.name;

 --41
 select m.title
 from movie m
 join rating ra on ra.mid=m.mid
 where ra.stars = 5 and 
 ra.mid not in (
  select ra2.mid
  from rating ra2
  where ra2.STARS>=1 and ra2.stars <=2

 );

 --42 crei qye esta mala xdxd tengo que repasar mas mañana de este tipo para enterder mas despacio pero no mames que consulta mas xd
 select h1.name,h2.name,h3.name 
 from likes l1
 join likes l2 on l2.id2=l1.id1
 join likes l3 on l3.id2=l2.id1
 join highschooler h1 on h1.id=l1.id1
 join highschooler h2 on h2.id=l2.id1
 join highschooler h3 on h3.id=l3.id1
where h1.id>h2.id and h1.id>h3.id and h2.id>h3.id;


--43
select re.NAME
from rating ra
join reviewer re on re.rid =ra.rid
having avg(ra.stars) =(
  select max(avg(ra2.stars))
  from rating ra2
  group by ra2.rid
)
group by re.name
;

--44
select distinct h1.name,h2.name
from friend f1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id1
where h1.id in (
  select f2.id2
  from friend f2
  join highschooler h3 on h3.id=f2.id1
  where f2.id2 = h2.id
)
; 

--45
select m.director
from movie m
where m.director is not  null
having count(m.mid)=1 
group by m.director;

--46
select distinct m.title
from rating ra
join movie m on m.mid =ra.mid
where ra.mid in(
  select ra2.mid
  from rating  ra2
  where ra2.stars >=1  and ra2.stars <=2
)
and 
ra.mid in(
  select ra3.mid
  from rating  ra3
  where ra3.stars >=4 
)
;

--47
select h1.name
from likes l1
join highschooler h1 on h1.id=l1.id1
where h1.id in(
  select l2.id1
  from likes l2
)
and h1.id not in(
select l3.id2
from likes l3
);

--48
select distinct re.name
from rating ra
join REVIEWER re on re.rid=ra.rid
where re.rid in(
  select re2.rid
  from rating re2
  join movie m on m.mid=re2.mid
  where m.director='Steven Spielberg'
);

--49
select h1.name
from likes l1 
join friend f1 on f1.ID1=l1.id1 and f1.id2=l1.id2
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
where h1.id not in (
  select l2.id2
  from likes l2
  where l2.id1 =h2.id
)
;

--50
select h1.name as Estudiante_Popular
from friend f1
join highschooler h1 on h1.id=f1.id2
having count(h1.id)>3
group by h1.name
union select 
re.name as Critico_Activo
from rating ra 
join reviewer re on re.rid=ra.rid
having count(ra.rid) > 2
group by re.name
;


