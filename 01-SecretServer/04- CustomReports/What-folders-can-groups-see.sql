SELECT DISTINCT	 
		g.GroupName
		,fp.FolderPath AS [Folder Path]
		,gfp.[Inherit Permissions]
		,gfp.[Permissions]	 
		,gfp.[Color]	 
FROM 	vGroupFolderPermissions gfp WITH (NOLOCK) 
		INNER JOIN vFolderPath fp WITH (NOLOCK)	 
			ON fp.FolderId = gfp.FolderId 
		INNER JOIN tbGroup g WITH (NOLOCK)	 
			ON gfp.GroupId = g.GroupId	 
WHERE
		gfp.OrganizationId = #Organization	 
--		AND 
--		g.GroupId = -#-Group
ORDER BY 1,2,3,4