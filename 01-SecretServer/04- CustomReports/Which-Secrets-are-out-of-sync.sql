SELECT
	CASE
		WHEN tbSecret.IsCustomExpiration = 1 THEN tbSecret.ExpiredFieldChangedDate + tbSecret.CustomExpirationDays 
		ELSE tbSecret.ExpiredFieldChangedDate + tbSecretType.ExpirationDays
	END AS 'Expiration Date'
	,IsNull(vFolderPath.FolderPath, 'No Folder') AS 'Folder Path'
	,tbSecret.SecretName AS 'Secret Name'
	,tbSecretType.SecretTypeName AS 'Secret Template'
	,CASE
		WHEN (tbSecret.PasswordChangeFailed = 1 AND tbSecret.AutoChangeOnExpiration = 1) THEN 'Remote Password Change Failed'
		ELSE 'Heartbeat Failed'
	END AS 'Out of Sync Reason'
FROM
	tbSecret WITH (NOLOCK)
INNER JOIN tbSecretType WITH (NOLOCK)
	ON tbSecretType.SecretTypeId = tbSecret.SecretTypeId
LEFT JOIN tbFolder WITH (NOLOCK)
	ON tbSecret.FolderId = tbFolder.FolderId
LEFT JOIN vFolderPath WITH (NOLOCK)
	ON tbFolder.FolderId = vFolderPath.FolderId
WHERE
	tbSecretType.ExpirationFieldId > 0
	AND
	tbSecretType.ExpirationDays > 0
	AND
	((tbSecret.PasswordChangeFailed = 1 
	AND
	tbSecret.AutoChangeOnExpiration = 1)
	OR
	tbSecret.LastHeartBeatStatus = 0)
	AND tbSecret.Active = 1
ORDER BY
	1, 2, 3, 4, 5