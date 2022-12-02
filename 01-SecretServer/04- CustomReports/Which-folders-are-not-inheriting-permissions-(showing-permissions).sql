SELECT	
			fp.FolderPath As [Folder Path]
			,gfp.[Inherit Permissions]
			,gdn.[DisplayName] AS [Group/User]
			,gfp.[Permissions]
			,gfp.[Color]
			
		FROM  vGroupFolderPermissions gfp WITH (NOLOCK)
			INNER JOIN vFolderPath fp WITH (NOLOCK)
				ON fp.FolderId = gfp.FolderId
			INNER JOIN vGroupDisplayName gdn WITH (NOLOCK)
				ON gdn.GroupId = gfp.GroupId
		WHERE
			gfp.OrganizationId = #Organization
			AND 
			gfp.[Inherit Permissions] = 'No'
		ORDER BY 1,2,3,4,5