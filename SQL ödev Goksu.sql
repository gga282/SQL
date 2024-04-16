USE NORTHWND;
--1. Çalýþanlarýmýz kaç farklý þehirde çalýþýyorlar
--2. Adresleri içinde 'House' kelimesi geçen çalýþanlar
--3. Herhangi bir bölge (Region) verisi olmayan çalýþanlar
--4. Çalýþanlarý adlarýný A-Z soyadlarýný Z-A olaracak þekilde tek sorguda listeleyelim
--5. Ürünleri; ürün adý, Fiyatý, KDV tutarý, KDV Dahil fiyatý þeklinde listeleyelim (KDV %18 olacak) 
--6. En pahalý 5 ürünü listeyelim
--7. Stok adedi 20-50 arasýndaki ürünlerin listesi
--8. Hangi ülkede kaç müþterimiz var
--9. Her kategoride kaç kalem ürün var (kategori adý, o kategorideki toplam ürün kalemi sayýsý)
--10. Her kategoride kaç adet ürün var (kategori adý, o kategorideki toplam ürün adedi (stock) sayýsý)
--11. 50 den fazla sipariþ alan personellerin ad, soyad, sipariþ adedi þeklinde listeleyelim
--12. Satýþ yapýlmayan ürün adlarýnýn listesi
--13. Ortalamanýn altýnda bir fiyata sahip olan ürünlerin adý ve fiyatý
--14. Hiç sipariþ vermeyen müþteriler
--15. Hangi tedarikçi hangi ürünü saðlýyor

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


