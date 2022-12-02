SELECT DISTINCT
			a.DateRecorded AS [Date Recorded],
			upn.displayname AS [User],
			ISNULL(fp.FolderPath, N'No folder assigned') as [Folder Path],
			s.secretname AS [Secret Name],
			a.Action,
			a.Notes,
			a.ipaddress As [IP Address]
		FROM tbauditsecret a WITH (NOLOCK)
			INNER JOIN tbuser u WITH (NOLOCK)
				ON u.userid = a.userid
				AND u.OrganizationId = #Organization
			INNER JOIN vUserDisplayName upn WITH (NOLOCK)
				ON u.UserId = upn.UserId
			INNER JOIN tbsecret s WITH (NOLOCK)
				ON s.secretid = a.secretid 
			LEFT JOIN vFolderPath fp WITH (NOLOCK)
				ON s.FolderId = fp.FolderId
			INNER JOIN tbGroupSecretPermission gsp  WITH (NOLOCK)
				ON s.SecretID = gsp.SecretID
			INNER JOIN tbUserGroup ug  WITH (NOLOCK)
				ON gsp.GroupID = ug.GroupID
			WHERE 
				gsp.PermissionID = 3
				AND ug.UserID = #USER
				AND a.DateRecorded >= #STARTDATE
				AND a.DateRecorded <= #ENDDATE
			ORDER BY 
				1 DESC,
				2,
				3,
				4,
				5,
				6,
				7