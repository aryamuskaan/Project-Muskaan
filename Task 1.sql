-- 1.Database creation
create database student_database;
use student_database;

-- 2.Datacreation
create table StudentInfo
(STU_ID int, STU_NAME varchar(100),
DOB DATE, PHONE_NO VARCHAR(10),EMAIL_ID varchar(50),
ADDRESS varchar(250),primary key (STU_ID));

create table CourseInfo
(COURSE_ID INT ,COURSE_NAME VARCHAR(100), COURSE_INSTRUCTOR_NAME VARCHAR(100), primary key (COURSE_ID));

create table EnrollmentInfo
(ENROLLMENT_ID INT, STU_ID int, COURSE_ID INT, ENROLL_STATUS varchar(20),
primary key (ENROLLMENT_ID), 
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CourseInfo(COURSE_ID));

Insert Into StudentInfo
(STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID ,ADDRESS) Values
('1001', 'Tom Hardy', '1993-08-23',9999999991, 'tom101@gamil.com', 'Banglore'),
('1002', 'Sam Joseph', '1994-08-23',9999999992, 'sam102@gamil.com', 'Banglore'),
('1003', 'Ben Issac', '1993-08-25',9999999993, 'ben103@gamil.com', 'Chennai'),
('1004', 'Kane Lewis', '1993-10-23',9999999994, 'kane104@gamil.com', 'Mumbai'),
('1005', 'Ian Robert', '1994-06-14',9999999995, 'ian105@gamil.com', 'Delhi'),
('1006', 'John Austin', '1991-07-17',9999999996, 'john106@gamil.com', 'Kochi');

Insert Into CourseInfo(COURSE_ID,COURSE_NAME, COURSE_INSTRUCTOR_NAME) values
(001, 'SQL','David'),
(002, 'Python','Artur'),
(003, 'AWS','Sebastian'),
(004, 'JAVA','Harry'),
(005, 'CSS','Jack');

insert into EnrollmentInfo(ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) values 
(10001, 1001, 001,'ENROLLED'),
(10002, 1003, 002,'ENROLLED'),
(10003, 1004, 004,'ENROLLED'),
(10004, 1002, 003,'ENROLLED'),
(10005, 1005, 003,'NOT ENROLLED'),
(10006, 1006, 005,'ENROLLED');

-- 3. Retrive the Student Information 
-- a) Retrieve Student details, Such as Student Name, Contact Informations and Enrollment Status
Select s.STU_NAME, s.PHONE_NO, s.ADDRESS,
e.ENROLL_STATUS 
from StudentInfo s join EnrollmentInfo e
on s.STU_ID=e.STU_ID order by e.ENROLL_STATUS ASC;

-- b) list of courses in which a specific student enrolled
select c.COURSE_NAME, s.STU_NAME
from EnrollmentInfo e join CourseInfo c on e.course_id = c.course_id
join StudentInfo s on s.STU_ID = e.STU_ID;

-- c) course information, including course name insturctor information
 Select * From CourseInfo;

-- d) course information for a specific course (SQL)
Select COURSE_ID,COURSE_NAME, COURSE_INSTRUCTOR_NAME
      from CourseInfo
      where COURSE_NAME='SQL';
      
-- e) course information for multiple courses
Select COURSE_ID,COURSE_NAME, COURSE_INSTRUCTOR_NAME
    from CourseInfo
    where COURSE_NAME in ('SQL','Python');
    
-- f) 
-- Adding new row in enrollment table 
insert into EnrollmentInfo(ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) values 
(10007, 1001, 002,'ENROLLED');

-- 4. Reporting and Analytics 
-- a) Number of students enrolled in each course 
Select c.Course_Name , count(c.course_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1;

-- b) Students enrolled in specific course 
select e.COURSE_ID, c.COURSE_NAME, s.STU_NAME
from CourseInfo c join EnrollmentInfo e on c.course_id=e.course_ID 
join StudentInfo s on s.STU_ID = e.STU_ID where e.enroll_status = 'ENROLLED';

-- c) Count of enrolled students for each instructor 
Select c.COURSE_INSTRUCTOR_NAME , count(e.Stu_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1;

-- d) Students who are enrolled in multiple courses 
Select e.stu_id , count(c.course_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
group by 1
having count(c.course_id) >1;

-- e) courses that have the highest number of enrolled students(arranging from highest to lowest)
Select e.stu_id , count(c.course_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1
having count(c.course_id) >1
order by count(c.course_id) desc