--1. DS NHÂN VIÊN CÓ HỌ NGUYỄN HOẶC TRẦN
--C1:
SELECT * FROM tblEmployee WHERE empName LIKE N'Nguyễn%' OR empName LIKE N'Trần%';
--C2: UNION (PHÉP HỢP) ~ OR
SELECT * FROM tblEmployee WHERE empName LIKE N'Nguyễn%' 
UNION
SELECT * FROM tblEmployee WHERE empName LIKE N'Trần%';


--2. DS NHÂN VIÊN HỌ NGUYỄN BẮT ĐẦU BẰNG CHỮ H VÀ CÓ MỨC LƯƠNG TRÊN 50.000
--C1:
SELECT * FROM tblEmployee WHERE empName LIKE 'H%' AND empSalary > 50000;  
--C2: INTERSECT (PHÉP GIAO) ~ AND
SELECT * FROM tblEmployee WHERE empName LIKE N'H%'
INTERSECT
SELECT * FROM tblEmployee WHERE empSalary > 50000;

--3. DS NHÂN VIÊN KHÔNG CÓ CHỨC VỤ 
--C1:
SELECT empSSN FROM tblEmployee 
EXCEPT 
SELECT supervisorSSN FROM tblEmployee;
--C2:
SELECT * FROM tblEmployee A
WHERE A.empSSN NOT IN (SELECT B.supervisorSSN FROM tblEmployee B WHERE B.supervisorSSN IS NOT NULL);

--4. DS NHÂN VIÊN QUẢN LÍ
SELECT DISTINCT B.* FROM tblEmployee A, tblEmployee B 
WHERE A.supervisorSSN=B.empSSN;

--5. DS NHÂN VIÊN VỪA LÀM CHO ProjectB VỪA LÀM CHO ProjectC
SELECT E.* FROM tblEmployee E, tblWorksOn W, tblProject P
WHERE E.empSSN=W.empSSN AND W.proNum=P.proNum
	AND (P.proName LIKE 'ProjectB')
INTERSECT 
SELECT E.* FROM tblEmployee E, tblWorksOn W, tblProject P
WHERE E.empSSN=W.empSSN AND W.proNum=P.proNum
	AND (P.proName LIKE 'ProjectC')


SELECT * FROM tblEmployee
SELECT * FROM tblWorksOn
SELECT * FROM tblProject



/*2. Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào. Thông tin
yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lí
*/
SELECT P.proNum, P.proName, D.depName
FROM tblProject P
JOIN tblDepartment D ON P.depNum = D.depNum
WHERE D.depName = N'Phòng Nghiên cứu và Phát triển';

/*4. Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An. Thông tin yêu
cầu: mã số nhân viên, họ tên nhân viên
*/
SELECT E.empSSN, E.empName
FROM tblEmployee E
WHERE E.supervisorSSN IN (
    SELECT empSSN FROM tblEmployee WHERE empName = N'Mai Duy An'
);