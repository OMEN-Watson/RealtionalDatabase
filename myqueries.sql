-- Q1

select count(*) from person where year_born <1974 and last_name like '%e';

-- Q2

select round( avg(run_time),2) from movie right join (select* from restriction where country='USA' and description='R' and production_year>1991) as a on a.title=movie.title;


-- Q3

 select title ,c from ( select title,count(*) as c from crew group by title) as sub where c=2;


-- Q4



-- Q5



-- Q6



-- Q7



-- Q8



-- Q9



-- Q10



