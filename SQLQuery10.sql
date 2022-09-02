--1) Вывести контрагента, у которого больше всего заказов
SELECT TOP 1 A.[Name], COUNT(*) AS 'Количество заказов'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name]
ORDER BY 2 DESC

--2) Вывести контрагента, у которого сумма заказов максимальная
SELECT TOP 1 A.[Name], SUM(O.[Amount]) AS 'Сумма'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name]
ORDER BY 'Сумма' DESC

--3) Вывести сумму заказов за прошлый год. Значение «прошлый год» должно высчитываться
DECLARE @previousYear INT = (SELECT YEAR(GETDATE()) - 1);
SELECT SUM([Amount])
FROM [test1].dbo.[Order]
WHERE YEAR([OrderDate]) = @previousYear;

--4) Вывести список контрагентов, которые сделали больше 1 заказа
DECLARE @AccountOrders TABLE(AccountName NVARCHAR(500), OrderCount INT);

INSERT INTO @AccountOrders
SELECT A.[Name], COUNT(*) AS 'Количество заказов'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name];

SELECT * FROM @AccountOrders
WHERE OrderCount > 1;