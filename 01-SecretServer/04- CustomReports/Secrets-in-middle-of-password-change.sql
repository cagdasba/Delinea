SELECT

     s.SecretName AS [Secret Name],
	 s.ChangePasswordNow [Stuck Password Change],
     s.AutoChangeOnExpiration AS [Auto Change],

	 IsNull(f.FolderPath, 'No Folder') AS 'Folder Path',

     s.PasswordChangeStatusLastChanged AS [Password Changed],
     st.SecretTypeName AS [Secret Template],
     s.Created AS [Created]
FROM tbSecret s
INNER JOIN tbSecretType st WITH (NOLOCK) ON s.SecretTypeID = st.SecretTypeID
LEFT JOIN tbFolder f WITH (NOLOCK)
ON s.FolderId = f.FolderId

WHERE
     s.Active = 1     /* active secrets */
AND
	s.ChangePasswordNow = 1