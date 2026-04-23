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



