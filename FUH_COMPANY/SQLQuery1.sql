/*1. LIỆT KÊ DANH SÁCH NHÂN VIÊN NỮ GỒM:
* MÃ, TÊN, LƯƠNG, GIỚI TÍNH, TUỔI, THÂM NIÊN
*/
SELECT A.empSSN, A.empName AS N'HỌ VÀ TÊN', A.empSalary, A.empSex,
		YEAR(GETDATE()) - YEAR(A.empBirthdate) AS N'TUỔI', 
		YEAR(GETDATE()) - YEAR(A.empStartdate) AS N'THÂM NIÊN'
FROM tblEmployee A
WHERE A.empSex='F'

/*2. HIỂN THỊ DS NHÂN VIÊN NAM CÓ MỨC LƯƠNG 75.000 ĐẾN 120.000
* SẮP XẾP TĂNG DẦN THEO MỨC LƯƠNG GỒM: MÃ, HỌ VÀ TÊN, LƯƠNG, GIỚI TÍNH
*/
SELECT A.empSSN, A.empName AS N'HỌ VÀ TÊN', A.empSalary, A.empSex
FROM tblEmployee A
WHERE A.empSex='M' 
	AND A.empSalary 
	BETWEEN 75000 AND 120000
ORDER BY A.empSalary ASC

/*3. DS NHÂN VIÊN NỮ CỦA PHÒNG SỐ 1 HOẶC PHÒNG SỐ 2 CÓ MỨC LƯƠNG TRÊN 50.000
* SẮP XẾP TĂNG DẦN THEO MỨC LƯƠNG, TĂNG DẦN THEO TUỔI: MÃ, HỌ VÀ TÊN, LƯƠNG, GIỚI TÍNH
*/
SELECT A.empSSN, A.empName AS N'HỌ VÀ TÊN', A.empSalary, A.empSex, A.depNum,
       YEAR(GETDATE()) - YEAR(A.empBirthdate) AS N'TUỔI'
FROM tblEmployee A
WHERE A.empSex='F' 
  AND A.depNum IN (1, 2) 
  AND A.empSalary > 50000
ORDER BY A.empSalary DESC, YEAR(GETDATE()) - YEAR(A.empBirthdate) ASC

/*4. DS NHÂN VIÊN THUỘC 'PHÒNG DỊCH VỤ CHĂM SÓC KHÁCH HÀNG'
* HIỂN THỊ: MÃ NV, TÊN NV, MÃ PHÒNG, TÊN PHÒNG
*/
-- C1:
SELECT A.empSSN, A.empName, A.depNum, B.depName
FROM tblEmployee A, tblDepartment B
WHERE A.depNum=B.depNum
-- C2:
SELECT A.empSSN, A.empName, A.depNum, B.depName
FROM tblEmployee A
	INNER JOIN tblDepartment B ON A.depNum=B.depNum

/*5. DS NHÂN VIÊN CÓ THAM GIA DỰ AN: MA NV, TEN NV, MA DU AN, TEN DU AN, SO GIO LV
*/
SELECT e.empSSN AS MaNV, e.empName AS TenNV, p.proNum AS MaDuAn, p.proName AS TenDuAn, w.workHours AS SoGioLV
FROM tblEmployee e
	JOIN tblWorksOn w ON e.empSSN=w.empSSN
	JOIN tblProject p ON w.proNum=p.proNum;

/*6. HAY CHO BIET DS NHAN VIEN NAM >= 45 TUOI HOAC NU >= 40 TUOI THUOC PHONG PHAN MEM TRONG NUOC
*/
SELECT e.empSSN, e.empName
FROM tblEmployee e
	JOIN tblDepartment d ON e.depNum=d.depNum
WHERE d.depName=N'Phòng Phần mềm trong nước' 
	AND(
		(e.empSex='M' AND DATEDIFF(YEAR, e.empBirthdate, GETDATE()) >= 45) 
		OR (e.empSex='F' AND DATEDIFF(YEAR, e.empBirthdate, GETDATE()) >= 40)
	);

/*7. HAY CHO BIET NHAN VIEN CO THAM GIA LAM VIEC CHO DU AN NHIEU HON 20
*/
SELECT e.empSSN, e.empName
FROM tblEmployee e
	JOIN tblWorksOn w ON e.empSSN=w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(w.proNum) > 20;

/*8. HAY CHO BIET NHAN VIEN CO THAM GIA LAM VIEC CHO DU AN NHIEU HON 20, SAP XEP TANG DAN THEO SO GIO LAM VIEC
*/
SELECT e.empSSN, e.empName, SUM(w.workHours) AS TotalHours
FROM tblEmployee e
	JOIN tblWorksOn w ON e.empSSN=w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(w.proNum) > 20
ORDER BY TotalHours ASC;

/*9. CHO BIET DS NHAN VIEN CO MUC LUONG NAM TRONG KHOANG 7000 DEN 12000
*/
SELECT e.empSSN, e.empName
FROM tblEmployee e
WHERE e.empSalary 
	BETWEEN 7000 AND 12000;

/*10. SAP XEP THEO THU TU TANG DAN THEO LUONG, GIAM DAN THEO MA PHONG
*/
SELECT e.empSSN, e.empName, e.empSalary AS Luong, d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
	JOIN tblDepartment d ON e.depNum=d.depNum
ORDER BY e.empSalary ASC, d.depNum DESC;

/*11. DS NV LAM VIEC O PHONG GIAI PHAP MANG TRUYEN THONG: MA, TEN, LUONG, TUOI, MA PHONG, TEN PHONG
*/
SELECT e.empSSN AS Ma, e.empName AS Ten, e.empSalary AS Luong, 
       DATEDIFF(YEAR, e.empBirthdate, GETDATE()) AS Tuoi, 
       d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
	JOIN tblDepartment d ON e.depNum=d.depNum
WHERE d.depName=N'Phòng Giải pháp mạng truyền thông';

/*12. SAP XEP GIAM DAN THEO TUOI
*/
SELECT e.empSSN AS Ma, e.empName AS Ten, e.empSalary AS Luong, 
       DATEDIFF(YEAR, e.empBirthdate, GETDATE()) AS Tuoi, 
       d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
	JOIN tblDepartment d ON e.depNum=d.depNum
ORDER BY Tuoi DESC;

