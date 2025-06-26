--1. THÔNG TIN NV CÓ THAM GIA DỰ ÁN
SELECT DISTINCT E.*
FROM tblEmployee E, tblWorksOn O
WHERE E.empSSN=O.empSSN;

--C2:
SELECT DISTINCT E.*
FROM tblEmployee E, tblWorksOn O
WHERE E.empSSN=O.empSSN;

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
SELECT D.depNum, D.depName, COUNT(E.empSSN) AS N'SL NV'
FROM tblDepartment D, tblEmployee E
WHERE D.depNum=E.depNum
GROUP BY D.depNum, D.depName

--5. MÃ PHÒNG, TÊN PHÒNG, SỐ LƯỢNG NHÂN VIÊN, TỔNG LƯƠNG TỪNG PHÒNG
SELECT D.depNum, D.depName, COUNT(E.empSSN) AS N'SO LUONG NV', SUM(E.empSalary) AS N'TONG LUONG'
FROM tblDepartment D, tblEmployee E
WHERE D.depNum=E.depNum
GROUP BY D.depNum, D.depName

--6. SỐ LƯỢNG DỰ ÁN VÀ TỔNG GIỜ LÀM TỪNG NHÂN VIÊN CÓ THAM GIA DỰ ÁN
--MÃ NV, TÊN NV, SỐ DỰ ÁN, TỔNG GIỜ LÀM
SELECT E.empSSN, E.empName, COUNT(O.proNum) AS 'SO DU AN', SUM(O.workHours) AS 'TONG GIO LAM'
FROM tblEmployee E
JOIN tblWorksOn O ON E.empSSN=O.empSSN
GROUP BY E.empSSN, E.empName;

--7. THỐNG KÊ THEO TỪNG PHÒNG SỐ NGƯỜI CÓ THAM GIA DỰ ÁN VÀ TỔNG SỐ GIỜ LÀM
--GỒM: MÃ PHÒNG, TÊN PHÒNG, SỐ NV THAM GIA, TỔNG GIỜ LÀM
SELECT D.depNum, D.depName, COUNT(DISTINCT O.empSSN) AS N'SỐ NV THAM GIA', SUM(O.workHours) AS 'TỔNG GIỜ LÀM'
FROM tblDepartment D
JOIN tblEmployee E ON D.depNum=E.depNum
JOIN tblWorksOn O ON E.empSSN=O.empSSN
GROUP BY D.depNum, D.depName;

--8. NHÂN VIÊN THAM GIA SỐ DỰ ÁN NHIỀU NHẤT THEO TỪNG PHÒNG
--GỒM: MÀ PHÒNG, TÊN PHÒNG, SỐ DỰ ÁN THAM GIA
SELECT DISTINCT D.depNum, D.depName, COUNT(*) AS N'SỐ DỰ ÁN'
FROM tblDepartment D, tblEmployee E, tblWorksOn O
WHERE D.depNum=E.depNum AND E.empSSN=O.empSSN
GROUP BY D.depNum, D.depName
HAVING COUNT(*) >= ALL(SELECT COUNT(B.depNum)
							FROM tblEmployee B, tblWorksOn C
							WHERE B.empSSN=C.empSSN
							GROUP BY B.depNum
							);
							
--9.SỐ LƯỢNG NHÂN VIÊN THAM GIA TỪNG DỰ ÁN
--GỒM: MÃ DỰ ÁN, TÊN DỰ ÁN, SỐ NV THAM GIA, TỔNG SỐ LÀM
SELECT P.proNum, P.proName, COUNT(O.empSSN) AS N'SỐ NV THAM GIA', SUM(O.workHours) AS N'TỔNG GIỜ LÀM'
FROM tblProject P
LEFT JOIN tblWorksOn O ON P.proNum=O.proNum
GROUP BY P.proNum, P.proName

--10 THÔNG TIN NHÂN VIÊN THAM GIA DỰ ÁN NHIỀU NHẤT THEO TỪNG PHÒNG
--GỒM: MÃ PHÒNG, TÊN PHÒNG, MÃ NV, SỐ DỰ ÁN THAM GIA








