SELECT
	IsNull(vFolderPath.FolderPath, 'No Folder') AS 'Folder Path'
	,tbSecret.SecretName AS 'Secret Name'
	,tbSecretType.SecretTypeName AS 'Secret Template'
	,checkoutUser.DisplayName AS 'Checked Out By'
	,tbSecret.CheckOutTime AS 'Check Out Time'
FROM
	tbSecret
INNER JOIN tbSecretType WITH (NOLOCK)
	ON tbSecretType.SecretTypeId = tbSecret.SecretTypeId
LEFT JOIN tbFolder  WITH (NOLOCK)
	ON tbSecret.FolderId = tbFolder.FolderId
LEFT JOIN vFolderPath  WITH (NOLOCK)
	ON tbFolder.FolderId = vFolderPath.FolderId
LEFT JOIN vUserDisplayName checkoutUser  WITH (NOLOCK)
	ON checkoutUser.UserId = tbSecret.CheckOutUserId
WHERE
	tbSecret.Active = 1
	AND
	tbSecret.CheckOutEnabled = 1
ORDER BY
	1, 2, 3, 4, 5