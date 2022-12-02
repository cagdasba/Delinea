SELECT DISTINCT
			fp.FolderPath AS [Folder Path]
			,ufp.[Inherit Permissions]
		FROM  vUserFolderPermissions ufp WITH (NOLOCK)
			INNER JOIN vFolderPath fp WITH (NOLOCK)
				ON fp.FolderId = ufp.FolderId
			INNER JOIN tbUserGroup ug WITH (NOLOCK)
				ON ufp.UserId = ug.UserId
			INNER JOIN tbGroup g WITH (NOLOCK)
				ON ug.GroupId = g.GroupId
		WHERE
			ufp.OrganizationId = #Organization
			AND (g.Active = 1 OR g.IsPersonal = 1)
			AND ufp.[Inherit Permissions] <> 'Yes'
		ORDER BY 1,2