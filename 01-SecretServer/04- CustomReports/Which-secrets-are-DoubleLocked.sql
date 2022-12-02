SELECT
	IsNull(vFolderPath.FolderPath, 'No Folder') AS 'Folder Path'
	,tbSecret.SecretName AS 'Secret Name'
	,tbSecretType.SecretTypeName AS 'Secret Template'
	,tbDoubleLock.Name AS 'DoubleLock Name'
FROM
	tbSecret WITH (NOLOCK)
INNER JOIN tbSecretType WITH (NOLOCK)
	ON tbSecretType.SecretTypeId = tbSecret.SecretTypeId
LEFT JOIN tbFolder WITH (NOLOCK)
	ON tbSecret.FolderId = tbFolder.FolderId
LEFT JOIN vFolderPath WITH (NOLOCK)
	ON tbFolder.FolderId = vFolderPath.FolderId
INNER JOIN tbDoubleLock WITH (NOLOCK)
	ON tbSecret.DoubleLockId = tbDoubleLock.DoubleLockId
WHERE
	tbSecret.Active = 1
ORDER BY
	1, 2, 3, 4