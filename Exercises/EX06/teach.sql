CREATE DATABASE teach

USE teach

CREATE TABLE STUDENT(
	StudentID VARCHAR(10) PRIMARY KEY,
	StudentName NVARCHAR(30),
	DateOfBirth DATE,
	StdAddress NVARCHAR(50)
);

CREATE TABLE COURSE(
	CourseID VARCHAR(10) PRIMARY KEY,
	CourseName NVARCHAR(30),
	FeesPay INT
);

CREATE TABLE SUBJECTS(
	SubjectID VARCHAR(10) PRIMARY KEY,
	SubjectName NVARCHAR(30),
	CourseID VARCHAR(10)
	FOREIGN KEY(CourseID) REFERENCES COURSE(CourseID)
);

CREATE TABLE TEACHER(
	TeacherID VARCHAR(10) PRIMARY KEY,
	TeacherName NVARCHAR(30),
	TchAddress NVARCHAR(50)
);

CREATE TABLE TEACHING(
	CourseID VARCHAR(10),
	TeacherID VARCHAR(10),
	PRIMARY KEY(CourseID, TeacherID),
	FOREIGN KEY(CourseID) REFERENCES COURSE(CourseID),
	FOREIGN KEY(TeacherID) REFERENCES TEACHER(TeacherID)
);

CREATE TABLE SUBJECT_ENROLMENT(
	StudentID VARCHAR(10),
	SubjectID VARCHAR(10),
	FeesPaidDate DATE
	PRIMARY KEY(StudentID, SubjectID),
	FOREIGN KEY(StudentID) REFERENCES STUDENT(StudentID),
	FOREIGN KEY(SubjectID) REFERENCES SUBJECTS(SubjectID)
);

INSERT INTO STUDENT (StudentID, StudentName, DateOfBirth, StdAddress) VALUES
('1', N'Nguyễn Văn A', '2001-05-10', N'Hà Nội'),
('2', N'Trần Thị B', '2000-02-15', N'Hồ Chí Minh'),
('3', N'Lê Văn C', '2002-09-20', N'Đà Nẵng'),
('4', N'Phạm Thị D', '2000-01-30', N'Hải Phòng'),
('5', N'Nguyễn Văn E', '1999-11-11', N'Cần Thơ'),
('6', N'Trần Văn F', '2001-07-22', N'Biên Hòa'),
('7', N'Lê Thị G', '2002-08-05', N'Nha Trang'),
('8', N'Nguyễn Văn H', '1998-04-18', N'Huế'),
('9', N'Phạm Văn I', '2003-12-25', N'Quy Nhơn'),
('10', N'Trần Thị J', '2001-06-30', N'Vũng Tàu');

INSERT INTO TEACHER (TeacherID, TeacherName, TchAddress) VALUES
('201', N'Lê Văn K', N'Hà Nội'),
('202', N'Trần Thị M', N'Đà Nẵng'),
('203', N'Nguyễn Văn N', N'Hồ Chí Minh'),
('204', N'Phạm Thị O', N'Hải Phòng');

INSERT INTO COURSE (CourseID, CourseName, FeesPay) VALUES
('301', N'Toán Cơ Bản', 1200000),
('302', N'Lý Cơ Bản', 1200000),
('303', N'Hóa Nâng Cao', 2700000),
('304', N'Văn Tăng Cường', 3200000);

INSERT INTO SUBJECTS (SubjectID, SubjectName, CourseID) VALUES
('101', N'Toán', '301'),
('102', N'Lý', '301'),
('103', N'Hóa', '302'),
('104', N'Văn', '301'),
('105', N'Tiếng Anh', '302'),
('106', N'Giáo Dục Công Dân', '303');

INSERT INTO TEACHING (TeacherID, CourseID) VALUES
('201', '301'),
('202', '301'),
('203', '302'),
('204', '301'),
('201', '303'),
('202', '303');

INSERT INTO SUBJECT_ENROLMENT (StudentID, SubjectID, FeesPaidDate) VALUES
('1', '101', '2023-01-15'),
('1', '102', '2023-02-20'),
('1', '105', '2023-03-10'),
('2', '101', '2023-04-05'),
('2', '103', NULL),
('3', '102', '2023-01-10'),
('3', '104', '2023-05-18'),
('4', '105', '2023-06-01'),
('5', '103', NULL),
('6', '101', '2023-02-28'),
('7', '102', '2023-03-15'),
('8', '104', '2023-01-01'),
('9', '105', NULL),
('10', '101', '2023-04-12');

SELECT * FROM STUDENT;

