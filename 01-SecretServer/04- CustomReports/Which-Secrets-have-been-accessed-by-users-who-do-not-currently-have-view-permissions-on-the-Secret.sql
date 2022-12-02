SELECT * FROM
	(SELECT
	userviewer.DisplayName AS 'Secret Viewer',
	IsNull(vfp.FolderPath, 'No Folder') AS 'Folder Path',
	s.SecretName AS 'Secret Name',
    auditview.Action AS 'Action',
    auditview.DateRecorded AS 'Action Date',
    CASE
        WHEN MAX(gsp.ViewPermission) + MAX(gsp.EditPermission) + MAX(gsp.OwnerPermission) >= 3 THEN 'View/Edit/Owner'
        WHEN MAX(gsp.ViewPermission) + MAX(gsp.EditPermission) + MAX(gsp.OwnerPermission) >= 2 THEN 'View/Edit'
        WHEN MAX(gsp.ViewPermission) + MAX(gsp.EditPermission) + MAX(gsp.OwnerPermission) >= 1 THEN 'View'
        ELSE 'None'
    END AS 'Permissions'
    FROM tbAuditSecret auditview WITH (NOLOCK)
    INNER JOIN tbSecret s WITH (NOLOCK)
        ON s.SecretID = auditview.SecretId
    INNER JOIN vUserDisplayName userviewer WITH (NOLOCK)
        ON userviewer.UserId = auditview.UserId
	LEFT JOIN tbFolder f WITH (NOLOCK)
		ON s.FolderId = f.FolderId
	LEFT JOIN vFolderPath vfp WITH (NOLOCK)
		ON f.FolderId = vfp.FolderId
    INNER JOIN tbUserGroup ug WITH (NOLOCK)
        ON userviewer.UserId = ug.UserID
    LEFT JOIN vGroupSecretPermissions gsp WITH (NOLOCK)
        ON gsp.GroupId = ug.GroupID AND gsp.SecretId = s.SecretId
	WHERE auditview.DateRecorded >= #STARTDATE
	AND	auditview.DateRecorded <= #ENDDATE
	GROUP BY userviewer.DisplayName, vfp.FolderPath, s.SecretName, auditview.Action, auditview.DateRecorded) allAudits
	WHERE allAudits.Permissions = 'None'