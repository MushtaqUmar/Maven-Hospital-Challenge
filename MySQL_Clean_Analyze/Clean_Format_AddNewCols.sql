CREATE DATABASE MGH_hospital;
USE MGH_hospital;

/* ===========================  Import data tables via 'Table Data Import Wizard' by right click on Tbales on Vavigation Section  ================================= */

/* +++++++++++++++++++++++++++  1. Patients Table: impoted : Cleaning, formatting, adding new cols ++++++++++++++++++++++++++++++++++*/
SELECT * FROM patients;
    
ALTER TABLE patients
RENAME COLUMN ï»¿Id
TO ID;

DESCRIBE patients;

ALTER TABLE patients
MODIFY COLUMN BIRTHDATE date;

UPDATE patients
SET ZIP = 000000
WHERE ZIP = '';

ALTER TABLE patients
MODIFY COLUMN ZIP INT NULL;


/* +++++++++++++++++++++++++++++++= 2. encounters Table: impoted : Cleaning, formatting, adding new cols +++++++++++++++++++++++++++++++++++++++== */
DESCRIBE encounters;

ALTER TABLE encounters
RENAME COLUMN ï»¿Id
TO ID;

/* Clean and format: Start */
UPDATE encounters
SET START = date_format(REPLACE(REPLACE(START ,'T',' '),'Z',' '), '%Y-%m-%d %H:%i:%s');

ALTER TABLE encounters
MODIFY COLUMN START datetime;


/* ADD NEW COLS: START DATE */
ALTER TABLE encounters
ADD COLUMN start_date date;

UPDATE encounters
SET start_date = date_format(START, '%Y-%m-%d');

ALTER TABLE encounters
ADD COLUMN start_time time;

UPDATE encounters
SET start_time = time(START);


/* Clean and format: STOP */
UPDATE encounters
SET STOP = date_format(REPLACE(REPLACE(STOP ,'T',' '),'Z',' '), '%Y-%m-%d %H:%i:%s');

ALTER TABLE encounters
MODIFY COLUMN STOP datetime;


/* ADD NEW COLS: stop DATE */
ALTER TABLE encounters
ADD COLUMN stop_date date;

UPDATE encounters
SET stop_date = date_format(STOP, '%Y-%m-%d');

ALTER TABLE encounters
ADD COLUMN stop_time time;

UPDATE encounters
SET stop_time = time(STOP);



/* +++++++++++++++++++++++++++++++= 3. ORGANIZATIONS Table: impoted : Cleaning, formatting +++++++++++++++++++++++++++++++++++++++== */
describe organizations;

ALTER TABLE organizations 
RENAME COLUMN ï»¿Id TO ID;

ALTER TABLE organizations 
MODIFY COLUMN ZIP INT;

