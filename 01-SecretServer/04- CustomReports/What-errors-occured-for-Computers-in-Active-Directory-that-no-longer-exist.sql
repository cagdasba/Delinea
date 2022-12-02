SELECT 
		Domain AS 'Domain', 
		ComputerName AS 'Computer Name', 
		'Last Connected to AD' = 
		CASE 
			WHEN LastLogon IS NULL THEN CONVERT(DATETIME, '1753')
			ELSE LastLogon
		END,
		cte.[Status]
	FROM tbComputer 
	INNER JOIN tbDomain ON tbDomain.DomainId = tbComputer.DomainId
	INNER JOIN
	( 
		SELECT *, ROW_NUMBER() OVER(PARTITION BY ComputerId ORDER BY ScanDate DESC) AS RowNumber
		FROM tbComputerScanLog
	)
	AS  cte ON cte.ComputerId = tbComputer.ComputerId AND cte.RowNumber = 1
	WHERE tbDomain.Active = 1
	AND tbDomain.EnableDiscovery = 1
	AND (LastLogon < DATEADD(month, -3, #ENDDATE) OR LastLogon IS NULL)
	AND (SELECT COUNT(*) FROM tbComputerAccount WHERE tbComputerAccount.ComputerId = tbComputer.ComputerId) = 0
	ORDER BY
		1,2,3 ASC