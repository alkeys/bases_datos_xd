select m.title
from movie m
where m.year >1990 and m.director='James Cameron';

select re.name
from rating ra
join REVIEWER re on re.rid=ra.RID
where ra.RATINGDATE is null;


select m.title,m.year
from MOVIE m
order by m.year desc;

--4
select distinct re.name,ra.stars
from rating ra 
join REVIEWER re on re.RID=ra.RID
join MOVIE m on m.MID = ra.MID
where m.TITLE ='E.T.';

--5
select distinct m.title 
from rating ra
join MOVIE m on m.mid=ra.MID
join REVIEWER re on re.rid =ra.RID
where re.name='Sarah Martinez';

--6
select re.name ,count(ra.rid) as caf
from rating ra
join REVIEWER re on re.RID=ra.RID
group by re.name
order by caf desc
;

--7
select m.title,max(ra.stars) as maximo
from rating ra
join MOVIE m on m.mid=ra.mid
group by m.TITLE
order by m.title;

--8
select m.title,avg(ra.stars)
from rating ra
join movie m on m.mid=ra.mid
group by m.title
having avg(ra.stars)>3;

--9
select distinct m.title
from rating ra
join MOVIE m on m.mid =ra.MID
where ra.stars>=4 and ra.stars<=5;

--10
select m.title
from movie m
where m.mid not in (
    select ra.MID
    from rating ra
    join REVIEWER re on re.rid=ra.RID
    where re.name = 'Sarah Martinez'
)
order by m.title;
-----------------------
--11
select distinct re.name 
from movie m 
join rating ra on ra.mid=m.MID
join REVIEWER re on re.rid=ra.RID
where m.director='Steven Spielberg';


--12
select m.title
from movie m
where m.year>(
    select avg(m2.year)
    from movie m2
)
order by m.title
;

--13
select m.title 
from movie m
where m.mid not in(
    select ra.mid
    from rating ra
);

--14
select re.name,m.title,count(ra.MID)
from movie m
join rating ra on ra.MID=m.mid
join REVIEWER re on re.rid=ra.rid
group by re.NAME,m.title
having count(ra.mid)>1;


--15
select r1.RID,r1.mid
from rating r1
join rating r2 on r2.RID=r1.rid
where r1.STARS<>r2.stars
;

--16
select m.DIRECTOR
from movie m
group by m.DIRECTOR
having count(m.director)>1;

--17
select re.NAME
from REVIEWER re
where exists (
    select 1
    from rating ra
    where ra.RID =re.RID
    and 
    ra.stars=5
);

--18
select m.title 
from movie m
union select re.name
from REVIEWER re ;


--19
select m.title
from movie m
where m.YEAR >=1930 and m.year <=1980;

-----------------
--20
select re.name
from REVIEWER re
where re.rid in(
    select ra.rid
    from rating ra
    join movie m on m.mid=ra.mid
    where m.title='Gone with the Wind'
)
and 
re.rid not in (
    select ra.rid
    from rating ra
    join movie m on m.mid=ra.mid
    where m.title = 'The Sound of Music'
)
;


--21
select m.title
from rating ra
join movie m on m.mid=ra.mid
group by m.title
having avg(ra.stars)=(
    select min(avg(r2.stars))
    from rating r2
    group by r2.mid
);

--22
select re.name
from REVIEWER re
join rating ra on ra.rid=re.rid
group by re.name
having count(ra.rid) =(
    select max(count(r1.rid))
    from rating r1
    group by r1.rid
);

--23
select distinct re2.name,re1.name
from rating ra
join rating ra2 on ra2.MID=ra.mid
join REVIEWER re1 on re1.RID =ra.rid
join reviewer re2 on re2.RID=ra2.rid 
where re1.rid<re2.rid;

--24
select m.director
from rating ra
join movie m on m.mid=ra.mid
group by m.director
having avg(ra.stars)>3.5 and m.director is not null
;

--25
select m.title
from movie m
where m.director ='James Cameron'
union 
select m.title
from rating ra
join movie m on m.mid=ra.mid
where ra.stars=5;

--26
select h1.name,h1.grade
from highschooler h1 
where h1.grade=10;

--27
select h1.name
from friend f1
join friend f2 on f2.ID1=f1.id2 and f2.ID2=f1.id1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f2.id1
where h2.name='Kyle';

--28
select h1.name,h1.grade,h2.name,h2.grade
from likes l1
join likes l2 on l2.ID1=l1.id2 and l2.id2=l1.id1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l2.id1
where h1.GRADE<h2.grade
;

--29
select h1.name,h2.name
from likes l1
join likes l2 on l2.id1=l1.id2 and l2.id2=l1.id1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l2.id1
where h1.id<h2.id;

--30
select h1.name
from highschooler h1 
where not exists(
    select 1
    from friend f1
    where f1.id2=h1.id 
);

select h1.name
from highschooler h1 
where h1.id not in (
    select f1.id1
    from friend f1
)
and 
h1.id not in (
    select f1.id2
    from friend f1
)
;

--31
select h1.name,h1.grade,h2.name,h2.grade
from friend f1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
where h1.id<h2.id and h1.grade =h2.grade;

--32 esta ta fea no molesten xdxd
select h1.name,h2.name,h3.name
from likes l1
join likes l2 on l2.id2=l1.id1
join highschooler h1 on h1.id=l1.id1
join highschooler h2 on h2.id=l1.id2 
join highschooler h3 on h3.id=l2.id1
where h1.id<>h3.id and h2.id<>h3.id ;


--33
select h1.name
from highschooler h1 
where h1.id in(
    select l1.id2
    from likes l1
    join highschooler h2 on h2.id=l1.id1
    where (h2.grade-h1.grade)>=2
);

--34
select distinct h1.name 
from friend f1
join highschooler h1 on h1.ID=f1.id1
group by h1.name
having count(f1.id1)>2;

--35
select distinct h1.name
from friend f1
join highschooler h1 on h1.id=f1.id1
where h1.id in(
    select f2.id2
    from friend f2
    join highschooler h2 on h2.id=f2.id1
    where h2.NAME='Andrew'
)
and 
h1.id in(
    select f3.id2
    from friend f3
    join highschooler h2 on h2.id=f3.id1
    where h2.NAME='Cassandra'
)
;

--36
select h1.name
from likes l1
join highschooler h1 on h1.id=l1.id1
group by h1.name
having count(l1.id1)=1;

--37
select h1.name
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


--38
select h1.name
from highschooler h1
where h1.id not in (
    select l1.id2
    from likes l1
);

--39
select count(f1.id1)
from friend f1;

--40
select h1.name 
from likes l1
join highschooler h1 on h1.id=l1.id1
where h1.id not in (
    select f1.id1
    from friend f1
);

--esta buena quien sabe aaja que feo esta este aaaak
select h1.name,h2.name
from friend f1 
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
where h2.id in(
    select l2.id2
    from likes l2
    where l2.id1=h1.id
)
and
h1.id not in (
    select f.id2
    from friend f
    where f.id1=h2.id
)
and 
h1.id not in(
    select l2.id2
    from likes l2
    where l2.id1=h2.id
)
;

--42
select distinct m.director
from rating ra
join rating ra2 on ra2.rid =ra.rid
join movie m on m.mid=ra.mid
where ra.stars=5 and ra2.stars<=2;

--43
select max(h2.grade-h1.grade)
from friend f1
join highschooler h1 on h1.id=f1.id1
join highschooler h2 on h2.id=f1.id2
group f1.id1;

--44
select h1.name
from highschooler h1
group by h1.name
having count(h1.name)>1;

--45
select re.name
from rating ra
join REVIEWER re on re.rid =ra.rid
group by re.name
having count(ra.rid)>=3;

--46 esta me costo tengo que reforzar mañana con la cosas de cruzas tablas
select H1.name,H2.name
from friend f1
join friend f2 on f2.id2=f1.id1
JOIN Highschooler H1 ON f1.ID1 = H1.ID
JOIN Highschooler H2 ON f2.ID2 = H2.ID
where f1.id1<>f2.id2
and not exists(
    select 1 from friend f3
    where f3.id1=f1.id1 and f3.id2=f2.id2
);
--no se si estoy cansao oc qu epero no me da el coco en esta aajaj
--tengo que repasar mas fundamentos porque me confundo con los cruses

--47
select m.title
from rating ra
join movie m on m.mid=ra.mid
where m.year<1980 and ra.stars is null;


--48
select h1.grade,count(l1.id2)
from likes l1
join highschooler h1 on h1.id =l1.id2
group by h1.grade;

--49
select m.title
from rating ra
join movie m on m.mid=ra.mid
where m.director is null and ra.stars=4;

--50
select h1.name as Estudiantes_Destacados
from friend f1
join highschooler h1 on h1.id=f1.id1
group by h1.name
having count(f1.id1)=3
union 
select h2.name
from likes l1
join highschooler h2 on h2.id=l1.id2
group by h2.name
having count(l1.id2)>=2;