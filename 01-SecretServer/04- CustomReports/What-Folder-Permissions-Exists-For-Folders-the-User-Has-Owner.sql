SELECT	
			fp.FolderPath As [Folder Path]
			,ufp1.[Inherit Permissions]
			,udn.[DisplayName] AS [User]
			,ufp1.[Permissions]
			,ufp1.[Color]
			,ufp.UserId
			
		FROM  vUserFolderPermissions ufp1 WITH (NOLOCK)
			INNER JOIN vFolderPath fp WITH (NOLOCK)
				ON fp.FolderId = ufp1.FolderId
			INNER JOIN vUserDisplayName udn WITH (NOLOCK)
				ON udn.UserId = ufp1.UserId
			INNER JOIN vUserFolderPermissions ufp WITH (NOLOCK)
				ON  fp.FolderId = ufp.FolderId 
		WHERE
			ufp1.OrganizationId = #ORGANIZATION
			AND
			ufp.UserId = #USER
			AND 
			ufp.OwnerPermission = 1
		ORDER BY 1,2,3,4,5