-- Pham Tuan Anh SE192861

CREATE TABLE Company(
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(100),
);

CREATE TABLE Staff(
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100),
    DOB DATE,
    Age INT,
    StaffAddress VARCHAR(255),
    Phone VARCHAR(25)
);

CREATE TABLE Task(
    TaskID INT PRIMARY KEY,
    TaskDescription VARCHAR(255)
);

CREATE TABLE Child(
    ChildID INT PRIMARY KEY,
    ChildName VARCHAR(100)
);

CREATE TABLE Work(
    StaffID INT,
    CompanyID INT,
	Since DATE
    FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY(CompanyID) REFERENCES Company(CompanyID)
);

CREATE TABLE Perform(
    StaffID INT,
    TaskID INT,
    FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY(TaskID) REFERENCES Task(TaskID)
);

CREATE TABLE HAS(
    StaffID INT,
    ChildID INT,
    FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY(ChildID) REFERENCES Child(ChildID)
);