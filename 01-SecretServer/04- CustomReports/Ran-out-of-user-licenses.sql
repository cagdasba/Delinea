SELECT 
		TOP 1 
		'Ran out of licenses (' 
		+ CONVERT(VARCHAR(200), LogMessage) 
		+ ')' AS Message
		,LogDate AS [Date]
FROM	 	tbSystemLog sl WITH (NOLOCK)
WHERE
		LogMessage LIKE 'ActiveDirectoryMonitor - Over License Limit%'
		AND
		LogDate > GetDate() - 7
ORDER BY 	SystemLogId DESC