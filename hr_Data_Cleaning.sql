USE Projects;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20)NULL;

DESCRIBE hr;

SET sql_safe_update = 0;

UPDATE hr
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY hire_date DATE;

UPDATE hr
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

UPDATE hr
SET termdate = CASE
    WHEN termdate = '' THEN '0000-00-00'
    ELSE DATE_FORMAT(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d')
END;

-- Update '0000-00-00' values to NULL
UPDATE hr
SET termdate = NULL
WHERE termdate = '0000-00-00';

-- Change the data type of the column to DATE
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Update empty strings to a temporary placeholder value
UPDATE hr
SET termdate = '0000-01-01'
WHERE termdate = '';

-- Update the temporary placeholder value to '0000-00-00'
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = '0000-01-01';


DESCRIBE hr;

-- Disable strict mode to allow '0000-00-00' as a valid date
SET sql_mode = '';

-- Update NULL values to '0000-00-00'
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age = timestampdiff(Year, birthdate, CURDATE());

SELECT 
	min(age) AS Youngest,
    max(age) AS Oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT * FROM hr





    