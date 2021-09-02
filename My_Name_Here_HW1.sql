



-- NAME: Xintao Li

/* INSTRUCTIONS
	- Please write a query to answer each question
	- You do not need to additionally write an answer (the query results are sufficient)
	- Clean and format appropriately
	- Submit this SQL file to Blackboard once completed
	- 25% deduction per day for late submissions
*/

/*
You should be VERY VERY comfortable with each of these statements:
	 SELECT - defines the columns you want in your final table
     FROM - what table(s) are you using
     WHERE - subset or filter data for rows that meet one or more conditions
     GROUP BY - determines level of aggregation, or what each row represents
     HAVING - subset groups (if used, must appear after the GROUP BY statement), similar to WHERE but for groups instead of individuals observations
     ORDER BY
*/

/* Please use the barcelona table in the airbnb schema for questions 1-20 */
USE airbnb;


/*
Data source: http://insideairbnb.com/get-the-data.html
*/

select * from barcelona
limit 5 ;


-- 1. Return  the id, name, neighbourhood, room_type, and price columns
select 
	id,
	name,
    neighbourhood,
    room_type,
    price
from barcelona;


-- 2. Add a column that estimates the annual income from each rental property 
	-- Calculated as price per night * 365 * occupancy rate
	-- Find an appropriate occupancy rate or make one up
	-- Format this column as a currency
	-- Alias columns appropriately

select 
	id,
	name,
    neighbourhood,
    room_type,
    price,
	concat('$', FORMAT(price * 365 * 0.277, 2)) as annual_income
from barcelona;




-- 3. How many rentals are available on Airbnb in Barcelona?
select
	count(*)
from barcelona;



-- 4. How many of these properties have an estimated income of over $50,000 per year?

select 
	count(*)
from barcelona
where price * 365 * 0.277 > 50000;


    
-- 5. How many neighbourhoods are represented on Airbnb in Barcelona?
select
	count(distinct(neighbourhood))
from barcelona;




-- 6. List those neighborhoods.
select
	distinct(neighbourhood)
from barcelona;




-- 7. Return a list of rentals available in la Sagrada Familia neighbourhood
select
	name
from barcelona
where neighbourhood = 'la Sagrada Familia';




-- 8. How many rentals is that?
select
	count(distinct(name))
from barcelona
where neighbourhood = 'la Sagrada Familia';



-- 9. How many rentals in la Sagrada Familia neighbourhood are under $100 per night?
select
	count(distinct(name))
from barcelona
where neighbourhood = 'la Sagrada Familia' and price < 100;


 
-- 10. How many Entire home/apts in la Sagrada Familia neighbourhood are under $100 per night?
select
	count(*)
from barcelona
where neighbourhood = 'la Sagrada Familia' and room_type = 'Entire home/apt';


    
-- 11. Return a list of Entire home/apts available for $100-$150 per night in either la Sagrada Familia, el Raval, or Sant Antoni neighbourhoods.
select
	name
from barcelona
where (price between 100 and 150) 
and (room_type = 'Entire home/apt')
and neighbourhood in ('la Sagrada Familia', 'el Raval', 'Sant Antoni');




 -- 12. How many rentals are described as modern in their description?
select 
	count(distinct(name))
from barcelona
where name like '%modern%';



-- 13. How many of those listings described as modern have a pool?
select 
	count(distinct(name))
from barcelona
where name like '%modern%' and name like '%pool%';




-- 14. return a list of hotel rooms for rent in la Sagrada Familia neighbourhood
	-- include id, name, neighbourhood, room type and price columns
	-- order high to low on price per night 
	-- format price as a currency
select
	id,
    name,
    neighbourhood,
    room_type,
    concat('$',price) AS price_curr
from barcelona
where neighbourhood = 'la Sagrada Familia'
order by price desc;




-- 15. Return the average price per night by neighborhood
	-- format as currency

select
	neighbourhood,
	concat('$', format(avg(price),2)) as avg_price
from barcelona
group by neighbourhood
order by avg(price) desc;


-- 16. Return the average price per night by neighborhood, ordered high to low on average price
	-- format as currency
select
	neighbourhood,
	concat('$', format(avg(price),2)) as avg_price
from barcelona
group by neighbourhood
order by avg(price) desc;


    
-- 17. Return the average price per night by neighborhood, ordered high to low on average price
	-- format as currency
	-- only include neighbourhoods with at least 500 rentals
select
	neighbourhood,
	concat('$', format(avg(price),2)) as avg_price
from barcelona
group by neighbourhood
having count(distinct(name)) >= 500
order by avg(price) desc;

    

-- 18. Return id, name, neighbourhood, room type and price for the 5 most expensive properites
	-- Format price as currency
select
	id,
    name,
    neighbourhood,
    room_type,
    concat('$',price) as price_curr
from barcelona
order by price desc
limit 5;



-- 19. Return the 5 most expensive neighborhoods (as identified for average price)
	-- Format price as currency
select
	id,
    name,
    neighbourhood,
    room_type,
    concat('$', format(avg(price),2)) as price_avg
from barcelona
group by neighbourhood
order by avg(price) desc
limit 5;




-- 20. Return the host_id, host_name, and total reviews for the 5 hosts with the most reviews
	-- Format total reviews to include the thousands separate (i.e. 1,000 not 1000)
select
	id as host_id,
    name as host_name,
    format(number_of_reviews,'#,0.00') as total_reviews
from barcelona
order by number_of_reviews desc
limit 5;




/* Please use the sfhomes table in the zillow schema for questions 21-30 */
USE zillow;
SELECT * FROM sfhomes LIMIT 5;



-- 21. Return a list of homes in the Potrero Hill neighborhood
select 
	*
from sfhomes
where neighborhood = 'Potrero Hill';

-- 22. How many homes is that?
select
	count(*)
from sfhomes
where neighborhood = 'Potrero Hill';

-- 23. Return a list of homes in the Potrero Hill neighborhood that last sold between 1.5 and 2 million dollars
select 
	*
from sfhomes
where neighborhood = 'Potrero Hill' and (lastsoldprice between 1500000 and 2000000);

    
-- 24. Return a list of Condominiums in the Potrero Hill or South of Market neighborhoods with zestimate's less than $1M
select
	*
from sfhomes
where 
(neighborhood = 'Potrero Hill' or neighborhood = 'South of Market') 
and (usecode = 'Condominium') 
and (zestimate < 1000000);


-- 25. How many homes in the Potrero Hill neighborhood last sold in the year 2016?
select
	count(*)
from sfhomes
where neighborhood = 'Potrero Hill'  and year(str_to_date(lastsolddate, '%m/%d/%Y')) = 2016;
  
-- 26. Return a table of homes sold on Mission Street
select
	*
from sfhomes
where z_address like '%mission%';
 

-- 27. Return the address, neighborhood and zestimate for homes in the South of Market, Potrero Hill, Bernal Heights, or Oceanview neighborhoods 
	-- Format zestimate as a currency
    -- ordered high to low on zestimate

select 
	z_address,
    neighborhood,
    concat('$',zestimate) as zestimate_curr
from sfhomes
where neighborhood in ('South of Market', 'Potrero Hill', 'Bernal Heights', 'Oceanview')
order by zestimate desc;


-- 28. Return a table that lists the neighborhood, number of homes, and average sale price by neighborhood for homes that last sold in 2016
	-- Format average sale price as a currency
    -- Order by neighborhood a to z
select
	neighborhood,
    count(*) as num_of_homes,
    concat('$', format(avg(lastsoldprice), 2)) as mean_price
from sfhomes
where year(str_to_date(lastsolddate, '%m/%d/%Y')) = 2016
group by neighborhood
order by neighborhood;



-- 29. Return a table that lists the neighborhood, number of homes, and average sale price by neighborhood for homes that last sold in 2016
	-- Format average sale price as a currency
    -- Order high to low by number of homes sold
    -- Only include neighborhoods with at least 15 homes that sold in 2016
select
	neighborhood,
    count(*) as num_of_homes,
    concat('$', format(avg(lastsoldprice), 2)) as mean_price
from sfhomes
where year(str_to_date(lastsolddate, '%m/%d/%Y')) = 2016
group by neighborhood
having num_of_homes >= 15
order by avg(lastsoldprice) desc;



-- 30 For the Potrero Hill and South of Market neighborhoods, return a table that lists the number of homes sold by year
select
	neighborhood,
    count(*) as num_of_homes,
    year(str_to_date(lastsolddate, '%m/%d/%Y')) as year
from sfhomes
where neighborhood in ('Potrero Hill','South of Market')
group by 3
order by 3 desc;




/* Please use the tables in the world dataset to answer questions 31-38

Where In The World Is Carmen Sandiego?
	Use your new SQL skills to chase down and capture an elusive and World-renowned thief, Carmen Sandiego. 
	Follow the clues and figure out where Carmen's headed, so we can catch her and bring her to justice.
*/

USE world;
select
	*
from city
limit 5;

select 
	*
from country
limit 5;

select
	*
from language
limit 5;

-- 31. Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
	-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
	-- so find the least populated country in Southern Europe, and we'll start looking for her there.
select
	Name, 
    Population
from country
where Region = 'Southern Europe'
order by Population
limit 1; # country is Holy See (Vatican City State)



-- 32. Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
	-- this country's officially recognized language. Check our databases and find out what language is
	-- spoken in this country, so we can call in a translator to work with you.
select
	Language,
    Isofficial
from language as l
inner join country as co on co.Code = l.CountryCode
where l.Isofficial = 'T' and co.Name = 'Holy See (Vatican City State)';  # Italian



-- 33. Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
	-- to a different country, a country where people speak only the language she was learning. Find out which
	-- nearby country speaks nothing but that language.
select
	co.Name,
    co.Code,
    l.Isofficial,
    count(l.Language) as lang_spoken
from (
		select 
			CountryCode
		from language
        where language = 'Italian'
		) as cc
inner join language as l on cc.CountryCode = l.CountryCode
inner join country as co on co.Code = cc.CountryCode
where co.Region = 'Southern Europe'
group by co.Name
having count(l.Language) = 1;

# the only nearby city that speak only italian is San Marino, Code:SMR





-- 34. Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
	-- There are only two cities she could be flying to in the country. One is named the same as the country – that
	-- would be too obvious. We're following our gut on this one; find out what other city in that country she might
	-- be flying to.

select 
	Name
from city 
where CountryCode = 'SMR';  # city name is Serravalle
					




-- 35. Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
	-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
	-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

select
	ci.Name,
    co.Region,
    co.Code
from country as co
left join city as ci on ci.CountryCode = co.Code
where (co.Region = 'South America') and (ci.Name like 'Se%');  # city is Serra, in BRA

    


-- 36. Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
	-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
	-- follow right behind you!

select
	Name,
    CountryCode
from city 
where ID = (
				select
					Capital
				from country
                where Code = 'BRA'
			);   # capital in BRA is BrasÃ­lia




-- 37. Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
	-- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
	-- landing dock.
    
    
    
    
    

-- 38. Clue #8: Lucky for us, she's getting confident. She left us a note, and I'm sure she thinks she's very clever, but
	-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our playdate of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.

select
	Name 
from city
where Population = 91084;





-- She's in ____Santa Monica_____!