--1) ������� �����������, � �������� ������ ����� �������
SELECT TOP 1 A.[Name], COUNT(*) AS '���������� �������'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name]
ORDER BY 2 DESC

--2) ������� �����������, � �������� ����� ������� ������������
SELECT TOP 1 A.[Name], SUM(O.[Amount]) AS '�����'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name]
ORDER BY '�����' DESC

--3) ������� ����� ������� �� ������� ���. �������� �������� ��� ������ �������������
DECLARE @previousYear INT = (SELECT YEAR(GETDATE()) - 1);
SELECT SUM([Amount])
FROM [test1].dbo.[Order]
WHERE YEAR([OrderDate]) = @previousYear;

--4) ������� ������ ������������, ������� ������� ������ 1 ������
DECLARE @AccountOrders TABLE(AccountName NVARCHAR(500), OrderCount INT);

INSERT INTO @AccountOrders
SELECT A.[Name], COUNT(*) AS '���������� �������'
FROM [test1].dbo.[Order] O
INNER JOIN [test1].dbo.[Account] A
ON O.[AccountId] = A.[Id]
GROUP BY A.[Name];

SELECT * FROM @AccountOrders
WHERE OrderCount > 1;