'Query 1'
'''Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first_name then by last_name.'''

SELECT first_name,last_name, allergies 
FROM patients
WHERE allergies = 'Penicillin' or allergies = 'Morphine'
ORDER BY allergies, first_name, last_name;

'Query 2'
'''Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.'''

SELECT city, COUNT(*) AS T
FROM patients
GROUP BY city
ORDER BY T DESC, city;

'Query 3'
'''Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"'''

SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION all
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

'Query 4'
'''Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.'''

WITH allergies_pop AS 
(SELECT allergies, 
 COUNT(allergies) AS popularity 
 FROM patients 
 GROUP BY allergies 
 ORDER BY popularity DESC)

SELECT *
FROM allergies_pop
WHERE allergies is NOT NULL;

'Query 5'
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade.Sort the list starting from the earliest birth_date.'''

SELECT first_name, last_name, birth_date 
FROM patients
wHere YEAR(birth_date) between 1970 and 1979  
ORDER BY birth_date;
