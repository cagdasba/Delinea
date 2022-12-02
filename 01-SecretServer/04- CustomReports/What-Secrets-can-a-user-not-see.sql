SELECT DISTINCT
			ISNULL(fp.FolderPath, N'No folder assigned') as [Folder Path]
			,s.SecretName AS [Secret Name]
			,st.SecretTypeName AS [Secret Template]
			,s.SecretId
		FROM tbSecret s WITH (NOLOCK)
			INNER JOIN tbSecretType st WITH (NOLOCK)
				ON s.SecretTypeId = st.SecretTypeId
			LEFT JOIN vFolderPath fp WITH (NOLOCK)
				ON s.FolderId = fp.FolderId
			LEFT JOIN (
				SELECT
					s.SecretId
				FROM tbSecret s WITH (NOLOCK)
					INNER JOIN tbGroupSecretPermission sgp WITH (NOLOCK)
						ON s.SecretId = sgp.SecretId AND sgp.PermissionID = 1
					INNER JOIN tbUserGroup ug WITH (NOLOCK)
						ON sgp.GroupId = ug.GroupId
					INNER JOIN tbUser u WITH (NOLOCK)
						ON u.UserId = ug.UserId
					INNER JOIN tbGroup g WITH (NOLOCK)
						ON sgp.GroupId = g.GroupId
					INNER JOIN tbSecretType st WITH (NOLOCK)
						ON s.SecretTypeId = st.SecretTypeId
					LEFT JOIN vFolderPath fp WITH (NOLOCK)
						ON s.FolderId = fp.FolderId
				WHERE
					u.UserId = #User
					AND
					s.Active = 1
					AND
					u.OrganizationId = #Organization
					AND
					(g.Active = 1 OR g.IsPersonal = 1)
				GROUP BY
					s.SecretId
			) hasAccess 
				ON s.SecretId = hasAccess.SecretId
		WHERE
				hasAccess.SecretID IS NULL
			AND
				s.Active = 1 
			AND
				st.OrganizationId = #Organization
		ORDER BY
			1,2,3,4