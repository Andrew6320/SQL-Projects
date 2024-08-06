-------------------------------------------------------------------------------
-- The following lines make sure you can rerun this whole script as often
-- as you want.
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS DayPass;
DROP TABLE IF EXISTS AdminStaff;
DROP TABLE IF EXISTS Trainer;
DROP TABLE IF EXISTS MonthlyContractMember;
DROP TABLE IF EXISTS Member;


-------------------------------------------------------------------------------
-- Task 1: Create Tables and Insert Data
-------------------------------------------------------------------------------

-- Table for AdminStaff data
CREATE TABLE AdminStaff (
    staffNo VARCHAR(7) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    dob DATE CHECK(dob < current_date) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('F', 'M', 'O')) NOT NULL,
    phoneNo VARCHAR(50) NOT NULL,
    startDate DATE NOT NULL,
    leavingDate DATE CHECK (leavingDate > startDate),
    role VARCHAR(50) CHECK (role IN('manager','secretary','assistant','facilities')) NOT NULL

);

-- Table for Trainer data
CREATE TABLE Trainer (
    staffNo VARCHAR(7) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    dob DATE CHECK(dob < current_date) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('F', 'M', 'O')) NOT NULL,
    phoneNo VARCHAR(50) NOT NULL,
    startDate DATE NOT NULL,
    leavingDate DATE CHECK (leavingDate > startDate),
    speciality VARCHAR(50) NOT NULL
);

-- Table for Member data
CREATE TABLE Member (
    memberNo VARCHAR(7) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    dob DATE CHECK(dob < current_date) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phoneNo VARCHAR(50) NOT NULL,
    healthConditions VARCHAR(255) 

);

-- Table for MonthlyContractMember data
CREATE TABLE MonthlyContractMember (
memberNo VARCHAR(7) PRIMARY KEY NOT NULL,
startDate DATE NOT NULL,
monthlyPrice MONEY NOT NULL,
paymentDay INTEGER NOT NULL,
endDate DATE CHECK (endDate > startDate),
FOREIGN KEY(memberNo) REFERENCES Member(memberNo)

);

-- Table for DayPass data
CREATE TABLE DayPass (
    memberNo VARCHAR(7) NOT NULL,
    startDate DATE NOT NULL,
    numberDays INTEGER CHECK (numberDays > 0) NOT NULL,
    price MONEY NOT NULL,
    PRIMARY KEY(memberNo, startDate),
    FOREIGN KEY(memberNo) REFERENCES Member(memberNo)

);

-- Table for Class data
CREATE TABLE Class (
    staffNo VARCHAR(7) NOT NULL,
    onDate DATE NOT NULL,
    onTime TIME NOT NULL,
    level VARCHAR(12) CHECK (level IN ('beginner','intermediate','advanced')) NOT NULL,
    maxNumber INTEGER NOT NULL,
    PRIMARY KEY (staffNo, onDate, onTime),
    FOREIGN KEY (staffNo) REFERENCES Trainer(staffNo)


);

-- Table for Booking data
CREATE TABLE Booking (
    staffNo VARCHAR(7) NOT NULL,
    onDate DATE NOT NULL,
    onTime TIME NOT NULL,
    memberNo VARCHAR(7) NOT NULL,
    bookingDate DATE NOT NULL,
    bookingTime TIME NOT NULL,
    PRIMARY KEY (staffNo, onDate, onTime, memberNo),
    FOREIGN KEY (staffNo, onDate, onTime) REFERENCES Class (staffNo, onDate, onTime),
    FOREIGN KEY (memberNo) REFERENCES Member (memberNo)

);

-- Add data to the tables:
INSERT INTO AdminStaff (staffNo, name, dob, gender, phoneNo, startDate, leavingDate, role)
Values('1', 'Jill Joffries', '1989-09-10', 'F', '+44 12312-234-656', '2018-12-01', NULL, 'manager');

INSERT INTO AdminStaff (staffNo, name, dob, gender, phoneNo, startDate, leavingDate, role)
Values('2', 'Fred Grimes', '1994-02-01', 'M', '0752343456', '2020-03-01', NULL, 'secretary');

INSERT INTO Trainer (staffNo, name, dob, gender, phoneNo, startDate, leavingDate, speciality)
Values('3','Virginia Vair', '1995-11-20', 'F', '01227523423', '2020-10-01', NULL, 'older adults');

INSERT INTO Trainer (staffNo, name, dob, gender, phoneNo, startDate, leavingDate, speciality)
Values('4','Jim Adams', '1990-12-31', 'M', '0752243456', '2021-09-01', NULL, 'pilates');

INSERT INTO Trainer (staffNo, name, dob, gender, phoneNo, startDate, leavingDate, speciality)
Values('5','Mike Taylor', '1974-07-03', 'M', '+44 (0) 71 234 4534 5653', '2018-12-01', NULL, 'personal training');

INSERT INTO Member(memberNo, name, dob, address, phoneNo,healthConditions)
Values('1', 'Adam Twill','1955-03-12','15 Giles Lane, CT2 7NZ, Canterbury', '0435-234-4354','issues with joints');

INSERT INTO Member(memberNo, name, dob, address, phoneNo,healthConditions)
Values('2', 'Sue Adams','2004-02-25','27 Cherry Street, CT4 7NF', '0752243451',NULL);

INSERT INTO Member(memberNo, name, dob, address, phoneNo,healthConditions)
Values('3', 'John Smith','2002-08-14','4 Harkness Drive, Canterbury', ' (0) 12 234 4534 5653',NULL);

INSERT INTO MonthlyContractMember(memberNo,startDate,monthlyPrice,paymentDay,endDate)
Values('1', '2022-01-01', 35.99, '5', NULL);

INSERT INTO MonthlyContractMember(memberNo,startDate,monthlyPrice,paymentDay,endDate)
Values('2', '2022-01-01', 12.99, '31', NULL);

INSERT INTO DayPass(memberNo, startDate,numberDays,price)
Values('3','2022-01-01','5',9.99);

INSERT INTO DayPass(memberNo, startDate,numberDays,price)
Values('3','2022-02-01','5',9.99);

INSERT INTO DayPass(memberNo, startDate,numberDays,price)
Values('3','2022-03-01','5',9.99);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('3','2022-03-02','06:30:00','intermediate', 10);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('3','2022-03-02','07:30:00','advanced', 10);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('4','2022-03-02','10:00:00','beginner', 5);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('4','2022-03-02','11:00:00','beginner', 5);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('5','2022-03-02','11:00:00','advanced', 2);

INSERT INTO Class(staffNo,onDate,onTime,level,maxNumber)
Values('5','2022-03-10','09:00:00','advanced', 2);

INSERT INTO Booking(staffNo,onDate,onTime,memberNo,bookingDate,bookingTime)
Values('3','2022-03-02','06:30:00','1','2022-02-28','20:23:00');

INSERT INTO Booking(staffNo,onDate,onTime,memberNo,bookingDate,bookingTime)
Values('3','2022-03-02','06:30:00','3','2022-03-01','10:41:00');

INSERT INTO Booking(staffNo,onDate,onTime,memberNo,bookingDate,bookingTime)
Values('4','2022-03-02','11:00:00','2','2022-03-01','12:48:00');

INSERT INTO Booking(staffNo,onDate,onTime,memberNo,bookingDate,bookingTime)
Values('5','2022-03-02','11:00:00','3','2022-03-01','13:23:00');



-------------------------------------------------------------------------------
-- Task 2: Query the Database
-------------------------------------------------------------------------------

-- 2.1: List the date and time of classes by Virginia Vair that have bookings.

SELECT DISTINCT Booking.onDate, Booking.onTime
FROM Class,Booking
WHERE Booking.staffNo = '3' AND Class.onTime=Booking.onTime ;

-- 2.2: List the name of all staff members that joined the company before 2020.

SELECT Trainer.name
FROM Trainer
WHERE Trainer.startDate < '2020-01-01' 
UNION
SELECT AdminStaff.name
FROM AdminStaff
WHERE AdminStaff.startDate < '2020-01-01'
;

-- 2.3: List the years and month, in which there are members with daypasses,
--      and show for each year-month combination how many daypasses were bought.

SELECT DISTINCT date_part('year',startDate) AS year, 
date_part('month',startDate) AS Month,
COUNT('month') AS count
FROM DayPass
group by startDate
;

-- 2.4 List the names of the instructors, the levels of their classes,
--     and the time and date for classes that do not currently have a booking.

SELECT DISTINCT Trainer.name,Class.level,Class.onTime,Class.onDate
FROM Trainer,Class,Booking
WHERE 
    Class.onTime!=Booking.onTime 
    AND Class.staffNo = Booking.staffNo
    AND Class.staffNo = Trainer.staffNo
;

-- 2.5 Show the names of the trainers with at least two classes at the same level.
--     Include the level and the number of classes (as classCount) in the output
--     table. Order the table from highest classCount to lowest.

SELECT Trainer.name,level,COUNT(Class.staffNo) AS classCount
FROM Trainer,Class
WHERE Class.level = Class.level AND Trainer.staffNo = Class.staffNo
GROUP BY Trainer.name,level
HAVING COUNT(Class.staffNo) > 1
ORDER BY classCount DESC
;


-- 2.6 Mike Tylor is on holidays from March 9th to March 11th. Jim Adams will
--     cover for him. Since there are no bookings for his classes yet, it's
--     sufficient to reassign the classes to Jim.

UPDATE Class
SET staffNo = '4'
WHERE onDate >= '2022-03-09' and onDate <= '2022-03-11' AND staffNo = '5'
;


-------------------------------------------------------------------------------
