-- Q1

select count(*) from person where year_born <1974 and last_name like '%e';

-- Q2

select round( avg(run_time),2) from movie right join (select* from restriction where country='USA' and description='R' and production_year>1991) as a on a.title=movie.title;


-- Q3

 select count(c) from ( select title,count(*) as c from crew group by title) as sub where c=2;


-- Q4

 select count(distinct id) from director d left join director_award da on d.title=da.title where da.title is null;


-- Q5


 select first_name,last_name from person right join(select id from (SELECT d.id, COUNT(d.id) AS num
        FROM director d
                RIGHT JOIN (
                        SELECT *
                        FROM movie
                        WHERE movie.major_genre = 'action'
                ) sub
                ON d.title = sub.title
        GROUP BY d.id) as groupone where num=(select min(num) from ( select d.id,count(d.id) as num from director d right join (select * from movie where movie.major_genre='action') sub on d.title=sub.title group by d.id) idList))idlist on person.id=idlist.id order by first_name;


-- Q6
SELECT round((
		SELECT COUNT(*)
		FROM movie
		WHERE major_genre = 'comedy'
			AND country = 'Australia'
	) * 1.0 / (
		SELECT COUNT(*)
		FROM movie
		WHERE major_genre = 'comedy'
	), 2) AS proportion;

-- Q7

SELECT movie.title, production_year
FROM movie
	RIGHT JOIN (
		SELECT title
		FROM (
			SELECT dlist.title, dlist.dy, dlist.dnum, alist.ay, alist.anum
				, dlist.dnum + alist.anum AS sum
			FROM (
				SELECT title, year_of_award AS dy, COUNT(year_of_award) AS dnum
				FROM director_award
				GROUP BY title, year_of_award
			) dlist
				INNER JOIN (
					SELECT title, year_of_award AS ay, COUNT(year_of_award) AS anum
					FROM actor_award
					GROUP BY title, year_of_award
				) alist
				ON dlist.title = alist.title
					AND dlist.dy = alist.ay
			ORDER BY sum
		) one
		WHERE one.sum = (
			SELECT MIN(dlist.dnum + alist.anum) AS sum
			FROM (
				SELECT title, year_of_award AS dy, COUNT(year_of_award) AS dnum
				FROM director_award
				GROUP BY title, year_of_award
			) dlist
				INNER JOIN (
					SELECT title, year_of_award AS ay, COUNT(year_of_award) AS anum
					FROM actor_award
					GROUP BY title, year_of_award
				) alist
				ON dlist.title = alist.title
					AND dlist.dy = alist.ay
			ORDER BY sum
		)
	) one
	ON movie.title = one.title;

-- Q8

SELECT title
FROM movie
WHERE title IN (
		SELECT title
		FROM crew_award
	)
	OR title IN (
		SELECT title
		FROM crew_award
	)
	OR title IN (
		SELECT title
		FROM director_award
	)
	OR title IN (
		SELECT title
		FROM writer_award
	)
	OR title IN (
		SELECT title
		FROM actor_award
	);

-- Q9

select 
  my, 
  array_agg(
    concat('(', title, ',', my, ')') 
    order by 
      title
  ) as newTitle 
from 
  (
    select 
      title, 
      year_of_award as my 
    from 
      movie_award 
    group by 
      title, 
      my 
    union 
    select 
      title, 
      year_of_award as my 
    from 
      crew_award 
    group by 
      title, 
      my 
    union 
    select 
      title, 
      year_of_award as my 
    from 
      director_award 
    group by 
      title, 
      my 
    union 
    select 
      title, 
      year_of_award as my 
    from 
      writer_award 
    group by 
      title, 
      my 
    union 
    select 
      title, 
      year_of_award as my 
    from 
      actor_award 
    group by 
      title, 
      my
  ) mcdwt 
group by 
  my 
order by 
  my;

-- Q10



