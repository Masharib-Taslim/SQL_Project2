/*
Once a student is passed out from a Institute or College, he/she is known as Alumni of the Institute. Alumni’s career growth plays important role in Institute’s ranking and other networking activities. In this project, career choices of alumni of two Universities will be analyzed with respect to their passing year as well as the course they completed. 

Dataset: Six .csv file (Alumni record of College A and College B) Higher Studies, Self Employed and Service/Job record 

College_A_HS ~ Higher Studies Record of College A
College_A_SE ~ Self Employed Record of College A
College_A_SJ ~ Service/Job Record of College A
College_B_HS ~ Higher Studies Record of College B
College_B_SE ~ Higher Studies Record of College B
College_B_SJ ~ Higher Studies Record of College B
Tasks to be performed

1. Create new schema as alumni
2. Import all .csv files into MySQL
3. Run SQL command to see the structure of six tables
4. Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.
5. Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
7. Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.
8. Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
9. Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
10. Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
11. Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
12. Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
13. Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni. 
14. Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
 
15. Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
16. Calculate the percentage of career choice of College A and College B Alumni
(w.r.t Higher Studies, Self Employed and Service/Job)
*/

-- Ques: 1
CREATE DATABASE alumni;
USE alumni;

-- Ques:2
-- all csv files imported

-- Ques:3
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Ques:4
-- in python

-- Ques:5
-- in excel

-- Ques:6
CREATE VIEW College_A_HS_V AS 
SELECT * FROM college_a_hs WHERE 
RollNo IS NOT NULL AND 
MotherName IS NOT NULL AND 
EntranceExam IS NOT NULL AND
HSDegree IS NOT NULL AND 
Institute IS NOT NULL AND
Location IS NOT NULL;

-- Ques:7
CREATE VIEW College_A_SE_V AS 
SELECT * FROM college_a_se WHERE
RollNo IS NOT NULL AND 
MotherName IS NOT NULL AND 
Organization IS NOT NULL AND 
Location IS NOT NULL; 

-- Ques:8
CREATE VIEW College_A_SJ_V AS 
SELECT * FROM college_a_sj WHERE
RollNo IS NOT NULL AND 
FatherName IS NOT NULL AND 
MotherName IS NOT NULL AND 
Organization IS NOT NULL AND 
Designation IS NOT NULL AND
Location IS NOT NULL; 

-- Ques:9
CREATE VIEW College_B_HS_V AS 
SELECT * FROM college_b_hs WHERE
RollNo IS NOT NULL AND 
HSDegree IS NOT NULL AND 
EntranceExam IS NOT NULL AND 
Institute IS NOT NULL;

-- Ques:10
CREATE VIEW College_B_SE_V AS 
SELECT * FROM college_b_se WHERE
RollNo IS NOT NULL AND 
MotherName IS NOT NULL AND 
Organization IS NOT NULL;

-- Ques:11
CREATE VIEW College_B_SJ_V AS 
SELECT * FROM college_b_sj WHERE
RollNo IS NOT NULL AND 
Designation IS NOT NULL;

-- Ques:12
DELIMITER $$
CREATE PROCEDURE lowercase_a1()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_A_HS_V;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE lowercase_a2()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_A_SE_V;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE lowercase_a3()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_A_SJ_V;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE lowercase_b1()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_B_HS_V;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE lowercase_b2()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_B_SE_V;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE lowercase_b3()
BEGIN
SELECT lower(Name),lower(FatherName),lower(MotherNmae) FROM College_B_SJ_V;
END $$
DELIMITER ;

-- Ques:13
-- in excel

-- Ques:14
DELIMITER $$
CREATE PROCEDURE get_name_collegeA (INOUT getname TEXT(160000))
BEGIN 
	DECLARE get_name INT DEFAULT 0;
    DECLARE get_namelist VARCHAR(400) DEFAULT "";
    
    DECLARE namedetail 
		CURSOR FOR 
			SELECT name FROM college_a_hs;
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET get_name = 1;
	
	OPEN namedetail ;
	getnamelist: LOOP
		FETCH namedetail INTO get_namelist;
        IF get_name = 1 THEN 
			LEAVE getnamelist ;
		END IF;
        SET getname = CONCAT (get_namelist,";",getname);
	END LOOP getnamelist;
    CLOSE namedetail;
END $$
DELIMITER ;

SET @getname ="";
CALL get_name_collegeA (@getname);
SELECT @getname ; 


-- Ques:15
DELIMITER $$
CREATE PROCEDURE get_name_collegeB (INOUT getnames TEXT(160000))
BEGIN 
	DECLARE get_names INT DEFAULT 0;
    DECLARE get_nameslist VARCHAR(400) DEFAULT "";
    
    DECLARE namesdetail 
		CURSOR FOR 
			SELECT name FROM college_b_hs;
	DECLARE CONTINUE HANDLER 
		FOR NOT FOUND SET get_names = 1;
	
	OPEN namesdetail ;
	getnameslist: LOOP
		FETCH namesdetail INTO get_nameslist;
        IF get_names = 1 THEN 
			LEAVE getnameslist ;
		END IF;
        SET getnames = CONCAT (get_nameslist,";",getnames);
	END LOOP getnameslist;
    CLOSE namesdetail;
END $$
DELIMITER ;

SET @getnames ="";
CALL get_name_collegeB (@getnames);
SELECT @getnames ;

-- Ques:16

select count(*) from college_a_hs;
-- 1157
select count(*) from college_a_se;
-- 724
select count(*) from college_a_sj;
-- 4006
-- total sum
-- 5887

select count(*) from college_b_hs;
-- 199
select count(*) from college_b_se;
-- 201
select count(*) from college_b_sj;
-- 1859
-- total sum
-- 2259

SELECT 'Higher Studies',(SELECT COUNT(*) / 5887 * 100 FROM college_a_hs)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_hs) 'College B Percentage'
UNION
SELECT 'Self Employed',(SELECT COUNT(*) / 5887 * 100 FROM college_a_se)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_se) 'College B Percentage'
UNION
SELECT 'Service Job',(SELECT COUNT(*) / 5887 * 100 FROM college_a_sj)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_sj) 'College B Percentage';



