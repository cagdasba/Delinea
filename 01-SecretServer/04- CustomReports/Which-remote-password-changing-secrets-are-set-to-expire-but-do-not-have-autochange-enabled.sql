SELECT
	IsNull(vfp.FolderPath, 'No Folder') AS 'Folder Path'
	,s.SecretName AS 'Secret Name'
	,st.SecretTypeName AS 'Secret Template'
	,s.SecretId
FROM 
	tbSecret s WITH (NOLOCK)
	INNER JOIN tbSecretType st WITH (NOLOCK)
		ON s.SecretTypeId = st.SecretTypeId
	LEFT JOIN tbFolder f WITH (NOLOCK)
		ON s.FolderId = f.FolderId
	LEFT JOIN vFolderPath vfp WITH (NOLOCK)
		ON vfp.FolderId = f.FolderId
WHERE
	s.Active  = 1
	AND
	st.PasswordTypeId IS NOT NULL
	AND
	st.PasswordTypeReady = 1
	AND
	(st.ExpirationFieldId IS NOT NULL AND st.ExpirationDays > 0)
	AND
	s.AutoChangeOnExpiration = 0
ORDER BY 1,2,3,4