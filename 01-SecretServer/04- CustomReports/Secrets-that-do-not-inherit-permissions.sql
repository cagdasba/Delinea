SELECT DISTINCT
			ISNULL(fp.FolderPath, N'No folder assigned') as [Folder Path]
			,s.SecretName AS [Secret Name]
			,st.SecretTypeName AS [Secret Template]
			,s.SecretId
FROM tbSecret s WITH (NOLOCK)
			INNER JOIN tbGroupSecretPermission sgp WITH (NOLOCK)
				ON s.SecretId = sgp.SecretId 
				AND sgp.PermissionID = 1
			INNER JOIN tbUserGroup ug WITH (NOLOCK)
				ON sgp.GroupId = ug.GroupId
			INNER JOIN tbSecretType st WITH (NOLOCK)
				ON s.SecretTypeId = st.SecretTypeId
			LEFT JOIN vFolderPath fp WITH (NOLOCK)
				ON s.FolderId = fp.FolderId
			LEFT JOIN tbFolder f WITH (NOLOCK)
				ON s.FolderId = f.FolderId
			INNER JOIN vUserDisplayName udn WITH (NOLOCK)
				ON udn.UserId = ug.UserId
			INNER JOIN vGroupSecretPermissions gsp
				ON sgp.GroupId = gsp.GroupId
				AND s.SecretID = gsp.SecretId
			INNER JOIN vGroupDisplayName gdn WITH (NOLOCK)
				ON gsp.GroupId = gdn.GroupId
			
		WHERE
			s.Active = 1 
			AND st.OrganizationId = #Organization
			AND gsp.[Inherit Permissions] = 'No'
	ORDER BY 1, 2, 3, 4