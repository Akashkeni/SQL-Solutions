
-- Weather Observation Station 9

SELECT distinct CITY FROM STATION 
WHERE 
CITY NOT LIKE "A%" and 
CITY NOT LIKE "E%" and 
CITY NOT LIKE "I%" and 
CITY NOT LIKE "O%" and 
CITY NOT LIKE "U%" ;

