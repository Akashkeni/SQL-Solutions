
-- Weather Observation Station 8

select distinct CITY from STATION where 
(CITY like 'A%' or CITY like 'E%' or CITY like 'I%' or  CITY like 'O%' or  CITY like 'U%'  ) 
and 
(CITY like '%A' or CITY like '%I' or CITY like '%O' or CITY like '%E' or CITY like '%U' );