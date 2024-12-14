Select * from album;

-- Problem Statement
Select * from invoice;
-- 1. Calculate Monthly-Wise Invoice Sales and sort them in descending order.

SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    SUM(Total) AS TotalSales
FROM
    invoice
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY TotalSales DESC;

-- 2. Write an SQL query to fetch the names of all employees and their managers.
select * from employee;

SELECT 
    e.FirstName AS EmployeeName,
    e.LastName AS EmployeeLastName,
    m.FirstName AS ManagerName,
    m.LastName AS ManagerLastName
FROM
    employee e
        LEFT JOIN
    employee m ON e.ReportsTo = m.EmployeeId;
    
-- 3. Find the names of customers who have made a purchase in the USA.
Select * from Customer;
SELECT 
    FirstName, LastName
FROM
    customer
WHERE
    Country = 'USA';
    
-- 4. Show the name of each genre and the total number of tracks in that genre.

Select * from Genre;
Select * from Track;

SELECT 
    g.Name AS GenreName, COUNT(t.TrackId) AS TotalTracks
FROM
    genre g
        JOIN
    track t ON g.GenreId = t.GenreId
GROUP BY g.Name;

-- 5. Show the name of each customer and the total amount they have spent on purchases.

Select * from Customer;
Select * from Invoice;

SELECT 
    c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM
    customer c
        JOIN
    invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId , c.FirstName , c.LastName;

-- 6. Find the name of the album with the highest unit price.
Select * from Album;
Select * from Track;
SELECT 
    a.Title AS AlbumName
FROM
    album a
        JOIN
    track t ON a.AlbumId = t.AlbumId
ORDER BY t.UnitPrice DESC
LIMIT 1;

-- 7. Display the percentage of missing values for billingstate and billingpostalcode columns respectively for the invoice table.
Select * from Invoice;

SELECT 
    (SUM(BillingState IS NULL) / COUNT(*)) * 100 AS BillingStateMissingPercentage,
    (SUM(BillingPostalCode IS NULL) / COUNT(*)) * 100 AS BillingPostalCodeMissingPercentage
FROM
    invoice;
    
--  8. Show the name of each track and the total number of times it has been purchased. 
Select * from TimesPurchased;
Select * from track;
SELECT 
    t.Name AS TrackName,
    COUNT(il.InvoiceLineId) AS TimesPurchased
FROM
    track t
        JOIN
    invoiceline il ON t.TrackId = il.TrackId
GROUP BY t.TrackId , t.Name;
 
-- 9. Find the name of the customer who has made the largest purchase in terms of total cost.
Select * from customer;
Select * from invoice;

SELECT 
    c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM
    customer c
        JOIN
    invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId , c.FirstName , c.LastName
ORDER BY TotalSpent DESC
LIMIT 1;

-- 10. Display the total amount spent by each customer and the number of invoices they have.
Select * from invoice;
Select * from customer;
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(i.InvoiceId) AS NumberOfInvoices,
    SUM(i.Total) AS TotalSpent
FROM
    customer c
        JOIN
    invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId , c.FirstName , c.LastName;

-- 11. Find the name of the artist who has the most tracks in the Chinook database.

Select * from artist;
Select * from album;
SELECT 
    a.Name AS ArtistName, COUNT(t.TrackId) AS TotalTracks
FROM
    artist a
        JOIN
    album al ON a.ArtistId = al.ArtistId
        JOIN
    track t ON al.AlbumId = t.AlbumId
GROUP BY a.ArtistId , a.Name
ORDER BY TotalTracks DESC
LIMIT 1;

-- 12. Find the names and email addresses of customers who have spent more than the average amount on invoices.
Select * from invoice;
Select * from customer;

WITH AvgSpent AS (
    SELECT AVG(Total) AS AverageSpent
    FROM invoice
)
SELECT 
    c.FirstName,
    c.LastName,
    c.Email
FROM 
    customer c
JOIN 
    invoice i
ON 
    c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId, c.FirstName, c.LastName, c.Email
HAVING 
    SUM(i.Total) > (SELECT AverageSpent FROM AvgSpent);
    
-- 13. List the names of all the artists that have tracks in the 'Rock' genre.
Select * from artist;
Select * from album;
Select * from track;
Select * from genre;
SELECT DISTINCT
    a.Name AS ArtistName
FROM
    artist a
        JOIN
    album al ON a.ArtistId = al.ArtistId
        JOIN
    track t ON al.AlbumId = t.AlbumId
        JOIN
    genre g ON t.GenreId = g.GenreId
WHERE
    g.Name = 'Rock';


