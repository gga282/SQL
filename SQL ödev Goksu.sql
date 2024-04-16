USE NORTHWND;
--1. �al��anlar�m�z ka� farkl� �ehirde �al���yorlar
--2. Adresleri i�inde 'House' kelimesi ge�en �al��anlar
--3. Herhangi bir b�lge (Region) verisi olmayan �al��anlar
--4. �al��anlar� adlar�n� A-Z soyadlar�n� Z-A olaracak �ekilde tek sorguda listeleyelim
--5. �r�nleri; �r�n ad�, Fiyat�, KDV tutar�, KDV Dahil fiyat� �eklinde listeleyelim (KDV %18 olacak) 
--6. En pahal� 5 �r�n� listeyelim
--7. Stok adedi 20-50 aras�ndaki �r�nlerin listesi
--8. Hangi �lkede ka� m��terimiz var
--9. Her kategoride ka� kalem �r�n var (kategori ad�, o kategorideki toplam �r�n kalemi say�s�)
--10. Her kategoride ka� adet �r�n var (kategori ad�, o kategorideki toplam �r�n adedi (stock) say�s�)
--11. 50 den fazla sipari� alan personellerin ad, soyad, sipari� adedi �eklinde listeleyelim
--12. Sat�� yap�lmayan �r�n adlar�n�n listesi
--13. Ortalaman�n alt�nda bir fiyata sahip olan �r�nlerin ad� ve fiyat�
--14. Hi� sipari� vermeyen m��teriler
--15. Hangi tedarik�i hangi �r�n� sa�l�yor

--1
SELECT DISTINCT Employees.City FROM Employees 
--2
SELECT * FROM Employees WHERE Employees.Address LIKE '%house%'
--3
SELECT * FROM Employees WHERE Employees.Region IS NULL
--4
SELECT LastName, FirstName FROM Employees Order BY LastName Desc, FirstName ASC
--5
SELECT ProductName,UnitPrice,UnitPrice*0.18 'KDV Tutari',(UnitPrice*0.18)+UnitPrice 'KDV Dahil' FROM Products
--6
SELECT TOP 5 UnitPrice,ProductName  FROM Products ORDER BY UnitPrice DESC
--7
SELECT ProductName,UnitsInStock FROM Products WHERE UnitsInStock BETWEEN 20 AND 50
--8
SELECT Country,COUNT(CustomerID) FROM Customers GROUP BY Country ORDER BY COUNT(CustomerID) DESC
--9
SELECT CategoryName,COUNT(CategoryName) FROM Categories LEFT JOIN Products ON Categories.CategoryID=Products.CategoryID GROUP BY CategoryName
--10
SELECT CategoryName,SUM(UnitsInStock) 'STOCK' FROM Categories LEFT JOIN Products ON Categories.CategoryID=Products.ProductID GROUP BY CategoryName
--11
SELECT Employees.FirstName,Employees.LastName,COUNT(OrderID) 'TOTAL' FROM Orders RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID GROUP BY FirstName,LastName HAVING COUNT(OrderID)>=50  
--12
SELECT ProductName,COUNT(OrderID) 'Satis Adedi' FROM Products LEFT JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID GROUP BY ProductName HAVING COUNT(OrderID)=0
--13
SELECT ProductName,UnitPrice FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
--14
SELECT Customers.CompanyName  FROM Customers LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID GROUP BY CompanyName HAVING COUNT(OrderID)=0
--15
SELECT Suppliers.CompanyName,Products.ProductName FROM Suppliers LEFT JOIN Products ON Suppliers.SupplierID=Products.SupplierID


