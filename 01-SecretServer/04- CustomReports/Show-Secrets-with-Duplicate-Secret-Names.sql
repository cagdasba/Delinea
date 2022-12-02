SELECT 
			s.SecretName as [Secret Name], 
			ISNULL(fp.FolderPath, N'No folder assigned') as [Folder Path], 
			st.SecretTypeName as [Secret Template], 
			s.SecretID as [Secret ID]
			FROM tbSecret s WITH (NOLOCK)
				INNER JOIN tbSecretType st WITH (NOLOCK) ON s.SecretTypeId = st.SecretTypeId
				LEFT JOIN vFolderPath fp WITH (NOLOCK) ON s.FolderId = fp.FolderId
				INNER JOIN tbSecret s2 WITH (NOLOCK) ON s.SecretName = s2.SecretName
				WHERE 
				st.Organizationid = #ORGANIZATION
				AND s.Active = 1
				AND s2.Active = 1
				AND s2.SecretId <> s.SecretId
			ORDER BY 1,2,3,4