SELECT * FROM tblEmployee
WHERE 

--2. THÔNG TIN NHÂN VIÊN KHÔNG THAM GIA DỰ ÁN NÀO CẢ
SELECT * FROM tblEmployee
EXCEPT
SELECT DISTINCT E.*
FROM tblEmployee E	
	JOIN tblWorksOn O ON E.empSSN=O.empSSN

SELECT * 
FROM tblEmployee E
LEFT JOIN tblWorksOn O ON E.empSSN=O.empSSN
WHERE O.empSSN IS NULL

SELECT * 
FROM tblEmployee E
RIGHT JOIN tblWorksOn O ON E.empSSN=O.empSSN