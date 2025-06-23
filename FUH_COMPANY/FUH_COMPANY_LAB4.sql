/*1. Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu:
mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
*/
SELECT E.empSSN, E.empName, D.depNum, D.depName
FROM tblEmployee E
JOIN tblDepartment D ON E.empSSN=D.mgrSSN
WHERE D.depName=N'Phòng Nghiên cứu và phát triển';

-- 2. Lấy thông tin dự án do "Phòng Nghiên cứu và phát triển" quản lý
SELECT p.proNum, p.proName, d.depName
FROM tblProject p
JOIN tblDepartment d ON p.depNum = d.depNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';

-- 3. Lấy thông tin phòng ban quản lý "ProjectB"
SELECT p.proNum, p.proName, d.depName
FROM tblProject p
JOIN tblDepartment d ON p.depNum = d.depNum
WHERE p.proName = 'ProjectB';

-- 4. Lấy thông tin nhân viên bị giám sát bởi "MaiDuyAn"
SELECT e.empSSN, e.empName
FROM tblEmployee e
WHERE e.supervisorSSN = (SELECT empSSN FROM tblEmployee WHERE empName = N'Mai Duy An');

-- 5. Lấy thông tin nhân viên giám sát "MaiDuyAn"
SELECT e.empSSN, e.empName
FROM tblEmployee e
WHERE e.empSSN = (SELECT supervisorSSN FROM tblEmployee WHERE empName = N'Mai Duy An');

-- 6. Lấy thông tin vị trí làm việc của "ProjectA"
SELECT l.locNum, l.locName
FROM tblLocation l
JOIN tblProject p ON l.locNum = p.proNum
WHERE p.proName = 'ProjectA';

-- 7. Lấy thông tin dự án làm việc tại "Tp. HCM"
SELECT p.proNum, p.proName
FROM tblProject p
JOIN tblLocation l ON p.proNum = l.locNum
WHERE l.locName = N'Tp. HCM';

-- 8. Lấy thông tin người phụ thuộc trên 18 tuổi
SELECT d.depName, d.depBirthdate, e.empName
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18;

-- 9. Lấy thông tin người phụ thuộc là nam giới
SELECT d.depName, d.depBirthdate, e.empName
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE d.depSex = 'M';

-- 10. Lấy thông tin nơi làm việc của "Phòng Nghiên cứu và phát triển"
SELECT d.depNum, d.depName, l.locName
FROM tblDepartment d
JOIN tblLocation l ON d.depNum = l.depNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';

-- 11. Lấy thông tin dự án làm việc tại "Tp. HCM" với phòng ban chịu trách nhiệm
SELECT p.projNum, p.projName, d.depName
FROM tblProject p
JOIN tblLocation l ON p.projNum = l.projNum
JOIN tblDepartment d ON p.depNum = d.depNum
WHERE l.locName = N'Tp. HCM';

-- 12. Lấy thông tin người phụ thuộc nữ của "Phòng Nghiên cứu và phát triển"
SELECT e.empName, d.depName, d.depRelationship
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dept ON e.depNum = dept.depNum
WHERE d.depSex = 'F' AND dept.depName = N'Phòng Nghiên cứu và phát triển';

-- 13. Lấy thông tin người phụ thuộc trên 18 tuổi của "Phòng Nghiên cứu và phát triển"
SELECT e.empName, d.depName, d.depRelationship
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dept ON e.depNum = dept.depNum
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18 AND dept.depName = N'Phòng Nghiên cứu và phát triển';

-- 14. Số lượng người phụ thuộc theo giới tính
SELECT d.depSex AS GioiTinh, COUNT(*) AS SoLuong
FROM tblDependent d
GROUP BY d.depSex;

-- 15. Số lượng người phụ thuộc theo mối liên hệ
SELECT d.depRelationship AS MoiLienHe, COUNT(*) AS SoLuong
FROM tblDependent d
GROUP BY d.depRelationship;

-- 16. Số lượng người phụ thuộc theo phòng ban
SELECT d.depNum, d.depName, COUNT(dep.empSSN) AS SoLuong
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName;

-- 17. Phòng ban có ít người phụ thuộc nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(dep.empSSN) AS SoLuong
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName
ORDER BY SoLuong ASC;

-- 18. Phòng ban có nhiều người phụ thuộc nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(dep.empSSN) AS SoLuong
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName
ORDER BY SoLuong DESC;

-- 19. Tổng số giờ tham gia dự án của mỗi nhân viên
SELECT e.empSSN, e.empName, d.depName, SUM(w.workHours) AS TongGio
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName;

-- 20. Tổng số giờ làm dự án của mỗi phòng ban
SELECT d.depNum, d.depName, SUM(w.workHours) AS TongGio
FROM tblDepartment d
JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY d.depNum, d.depName;

-- 21. Nhân viên có số giờ tham gia dự án ít nhất
SELECT TOP 1 e.empSSN, e.empName, SUM(w.workHours) AS TongGio
FROM tblEmployee e
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY TongGio ASC;

-- 22. Nhân viên có số giờ tham gia dự án nhiều nhất
SELECT TOP 1 e.empSSN, e.empName, SUM(w.workHours) AS TongGio
FROM tblEmployee e
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY TongGio DESC;

-- 23. Nhân viên lần đầu tiên tham gia dự án
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(w.proNum) = 1;

-- 24. Nhân viên lần thứ hai tham gia dự án
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(w.proNum) = 2;

-- 25. Nhân viên tham gia tối thiểu hai dự án
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName, d.depName
HAVING COUNT(w.proNum) >= 2;

-- 26. Số lượng thành viên của mỗi dự án
SELECT p.projNum, p.projName, COUNT(w.empSSN) AS SoLuongThanhVien
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName;

-- 27. Tổng số giờ làm của mỗi dự án
SELECT p.projNum, p.projName, SUM(w.workHours) AS TongGio
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName;

-- 28. Dự án có số lượng thành viên ít nhất
SELECT TOP 1 p.projNum, p.projName, COUNT(w.empSSN) AS SoLuongThanhVien
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName
ORDER BY SoLuongThanhVien ASC;

-- 29. Dự án có số lượng thành viên nhiều nhất
SELECT TOP 1 p.projNum, p.projName, COUNT(w.empSSN) AS SoLuongThanhVien
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName
ORDER BY SoLuongThanhVien DESC;

-- 30. Dự án có tổng số giờ làm ít nhất
SELECT TOP 1 p.projNum, p.projName, SUM(w.workHours) AS TongGio
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName
ORDER BY TongGio ASC;

-- 31. Dự án có tổng số giờ làm nhiều nhất
SELECT TOP 1 p.projNum, p.projName, SUM(w.workHours) AS TongGio
FROM tblProject p
LEFT JOIN tblWorksOn w ON p.projNum = w.proNum
GROUP BY p.projNum, p.projName
ORDER BY TongGio DESC;

-- 32. Số lượng phòng ban theo mỗi nơi làm việc
SELECT l.locName, COUNT(DISTINCT d.depNum) AS SoLuongPhongBan
FROM tblLocation l
LEFT JOIN tblDepartment d ON l.depNum = d.depNum
GROUP BY l.locName;

-- 33. Số lượng chỗ làm việc theo mỗi phòng ban
SELECT d.depNum, d.depName, COUNT(l.locNum) AS SoLuongChoLamViec
FROM tblDepartment d
LEFT JOIN tblLocation l ON d.depNum = l.depNum
GROUP BY d.depNum, d.depName;

-- 34. Phòng ban có nhiều chỗ làm việc nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(l.locNum) AS SoLuongChoLamViec
FROM tblDepartment d
LEFT JOIN tblLocation l ON d.depNum = l.depNum
GROUP BY d.depNum, d.depName
ORDER BY SoLuongChoLamViec DESC;

-- 35. Phòng ban có ít chỗ làm việc nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(l.locNum) AS SoLuongChoLamViec
FROM tblDepartment d
LEFT JOIN tblLocation l ON d.depNum = l.depNum
GROUP BY d.depNum, d.depName
ORDER BY SoLuongChoLamViec ASC;

-- 36. Địa điểm có nhiều phòng ban làm việc nhất
SELECT TOP 1 l.locName, COUNT(DISTINCT d.depNum) AS SoLuongPhongBan
FROM tblLocation l
LEFT JOIN tblDepartment d ON l.depNum = d.depNum
GROUP BY l.locName
ORDER BY SoLuongPhongBan DESC;

-- 37. Địa điểm có ít phòng ban làm việc nhất
SELECT TOP 1 l.locName, COUNT(DISTINCT d.depNum) AS SoLuongPhongBan
FROM tblLocation l
LEFT JOIN tblDepartment d ON l.depNum = d.depNum
GROUP BY l.locName
ORDER BY SoLuongPhongBan ASC;

-- 38. Nhân viên có nhiều người phụ thuộc nhất
SELECT TOP 1 e.empSSN, e.empName, COUNT(d.empSSN) AS SoLuongPhuThuoc
FROM tblEmployee e
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY SoLuongPhuThuoc DESC;

-- 39. Nhân viên có ít người phụ thuộc nhất
SELECT TOP 1 e.empSSN, e.empName, COUNT(d.empSSN) AS SoLuongPhuThuoc
FROM tblEmployee e
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
GROUP BY e.empSSN, e.empName
ORDER BY SoLuongPhuThuoc ASC;

-- 40. Nhân viên không có người phụ thuộc
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
WHERE dep.empSSN IS NULL;

-- 41. Phòng ban không có người phụ thuộc
SELECT d.depNum, d.depName
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName
HAVING COUNT(dep.empSSN) = 0;

-- 42. Nhân viên chưa tham gia dự án nào
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE w.empSSN IS NULL;

-- 43. Phòng ban không có nhân viên tham gia dự án
SELECT d.depNum, d.depName
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY d.depNum, d.depName
HAVING COUNT(w.empSSN) = 0;

-- 44. Phòng ban không có nhân viên tham gia "ProjectA"
SELECT d.depNum, d.depName
FROM tblDepartment d
LEFT JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
LEFT JOIN tblProject p ON w.proNum = p.projNum
WHERE p.projName = 'ProjectA' OR p.projName IS NULL
GROUP BY d.depNum, d.depName
HAVING COUNT(CASE WHEN p.projName = 'ProjectA' THEN 1 END) = 0;

-- 45. Số lượng dự án được quản lý theo mỗi phòng ban
SELECT d.depNum, d.depName, COUNT(p.projNum) AS SoLuongDuAn
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName;

-- 46. Phòng ban quản lý ít dự án nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(p.projNum) AS SoLuongDuAn
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
ORDER BY SoLuongDuAn ASC;

-- 47. Phòng ban quản lý nhiều dự án nhất
SELECT TOP 1 d.depNum, d.depName, COUNT(p.projNum) AS SoLuongDuAn
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
ORDER BY SoLuongDuAn DESC;

-- 48. Phòng ban có hơn 5 nhân viên và quản lý dự án
SELECT d.depNum, d.depName, COUNT(e.empSSN) AS SoLuongNhanVien, p.projName
FROM tblDepartment d
JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName, p.projName
HAVING COUNT(e.empSSN) > 5;

-- 49. Nhân viên thuộc "Phòng Nghiên cứu" không có người phụ thuộc
SELECT e.empSSN, e.empName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
WHERE d.depName = N'Phòng Nghiên cứu' AND dep.empSSN IS NULL;

-- 50. Tổng số giờ làm của nhân viên không có người phụ thuộc
SELECT e.empSSN, e.empName, SUM(w.workHours) AS TongGio
FROM tblEmployee e
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE dep.empSSN IS NULL
GROUP BY e.empSSN, e.empName;

-- 51. Tổng số giờ làm của nhân viên có hơn 3 người phụ thuộc
SELECT e.empSSN, e.empName, COUNT(d.empSSN) AS SoLuongPhuThuoc, SUM(w.workHours) AS TongGio
FROM tblEmployee e
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(d.empSSN) > 3;

-- 52. Tổng số giờ làm của nhân viên dưới quyền "MaiDuyAn"
SELECT e.empSSN, e.empName, SUM(w.workHours) AS TongGio
FROM tblEmployee e
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE e.superiorSSN = (SELECT empSSN FROM tblEmployee WHERE empName = N'MaiDuyAn')
GROUP BY e.empSSN, e.empName;

-- Truy vấn bổ sung: Danh sách nhân viên nữ
SELECT e.empSSN, e.empName AS 'Ho Va Ten', e.empSalary, e.empSex, 
       YEAR(GETDATE()) - YEAR(e.empBirthdate) AS 'TUOI', 
       YEAR(GETDATE()) - YEAR(e.empStartdate) AS 'THAM NIEN'
FROM tblEmployee e
WHERE e.empSex = 'F';

-- Truy vấn bổ sung: Nhân viên nam với lương từ 75000 đến 120000
SELECT * FROM tblEmployee
WHERE empSex = 'M' AND empSalary BETWEEN 75000 AND 120000
ORDER BY empSex, empName, empSalary, empSSN ASC;

-- Truy vấn bổ sung: Nhân viên nữ của phòng 1 hoặc 2 với lương trên 50000
SELECT e.empSSN, e.empName, YEAR(GETDATE()) - YEAR(e.empBirthdate) AS 'TUOI', e.empSalary
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
WHERE e.empSex = 'F' AND d.depNum IN ('1', '2') AND e.empSalary > 50000
ORDER BY e.empSalary DESC, TUOI ASC, e.empSSN ASC, e.empName ASC, e.empSex ASC;

-- Truy vấn bổ sung: Nhân viên thuộc "Phòng Dịch vụ chăm sóc khách hàng"
SELECT e.* FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
WHERE d.depName = N'Phòng Dịch vụ chăm sóc khách hàng';

-- Truy vấn bổ sung: Danh sách nhân viên tham gia dự án
SELECT e.empSSN AS MaNV, e.empName AS TenNV, p.projNum AS MaDuAn, p.projName AS TenDuAn, w.workHours AS SoGioLV
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
JOIN tblProject p ON w.projNum = p.projNum;

-- Truy vấn bổ sung: Nhân viên nam >= 45 tuổi hoặc nữ >= 40 tuổi thuộc "Phòng Phần mềm trong nước"
SELECT e.empSSN, e.empName
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
WHERE d.depName = N'Phòng Phần mềm trong nước' 
AND ((e.empSex = 'M' AND DATEDIFF(YEAR, e.empBirthdate, GETDATE()) >= 45) 
     OR (e.empSex = 'F' AND DATEDIFF(YEAR, e.empBirthdate, GETDATE()) >= 40));

-- Truy vấn bổ sung: Nhân viên tham gia hơn 20 dự án
SELECT e.empSSN, e.empName
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(w.projNum) > 20;

-- Truy vấn bổ sung: Nhân viên tham gia hơn 20 dự án, sắp xếp tăng dần theo giờ làm
SELECT e.empSSN, e.empName, SUM(w.workHours) AS TotalHours
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(w.projNum) > 20
ORDER BY TotalHours ASC;

-- Truy vấn bổ sung: Nhân viên có lương từ 7000 đến 12000
SELECT e.empSSN, e.empName
FROM tblEmployee e
WHERE e.empSalary BETWEEN 7000 AND 12000;

-- Truy vấn bổ sung: Sắp xếp theo lương tăng dần, mã phòng giảm dần
SELECT e.empSSN, e.empName, e.empSalary AS Luong, d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
ORDER BY e.empSalary ASC, d.depNum DESC;

-- Truy vấn bổ sung: Nhân viên làm việc tại "Phòng Giải pháp Mạng Truyền thông"
SELECT e.empSSN AS Ma, e.empName AS Ten, e.empSalary AS Luong, 
       DATEDIFF(YEAR, e.empBirthdate, GETDATE()) AS Tuoi, 
       d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
WHERE d.depName = N'Phòng Giải pháp Mạng Truyền thông';

-- Truy vấn bổ sung: Sắp xếp giảm dần theo tuổi
SELECT e.empSSN AS Ma, e.empName AS Ten, e.empSalary AS Luong, 
       DATEDIFF(YEAR, e.empBirthdate, GETDATE()) AS Tuoi, 
       d.depNum AS MaPhong, d.depName AS TenPhong
FROM tblEmployee e
JOIN tblDepartment d ON e.depNum = d.depNum
ORDER BY Tuoi DESC;