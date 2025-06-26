--1. THÔNG TIN NV CÓ THAM GIA DỰ ÁN
SELECT DISTINCT E.*
FROM tblEmployee E, tblWorksOn O
WHERE E.empSSN=O.empSSN

SELECT * FROM tblEmployee
WHERE 

--2. THÔNG TIN NHÂN VIÊN KHÔNG THAM GIA DỰ ÁN NÀO CẢ
--C1:
SELECT * FROM tblEmployee
EXCEPT
SELECT DISTINCT E.*
FROM tblEmployee E	
	JOIN tblWorksOn O ON E.empSSN=O.empSSN;
--C2:
SELECT * FROM tblEmployee E
LEFT JOIN tblWorksOn O ON E.empSSN=O.empSSN
WHERE O.empSSN IS NULL;

SELECT * FROM tblEmployee E
RIGHT JOIN tblWorksOn O ON E.empSSN=O.empSSN;

--3. THÔNG TIN NV GỒM: MÃ PHÒNG, TÊN PHÒNG, MÃ NV, TÊN NV, LƯƠNG
SELECT D.depNum, D.depName, E.empSSN, E.empName, E.empSalary
FROM tblDepartment D, tblEmployee E
WHERE D.depNum=E.depNum
--4. THÔNG TIN NV GỒM: MÃ PHÒNG, TÊN PHÒNG, SỐ LƯỢNG NHÂN VIÊN

--5. MÃ PHÒNG, TÊN PHÒNG, SỐ LƯỢNG NHÂN VIÊN, TỔNG LƯƠNG TỪNG PHÒNG