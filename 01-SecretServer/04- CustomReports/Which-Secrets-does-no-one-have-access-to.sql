SELECT
s.SecretName
,ISNULL(fp.FolderPath, 'None') AS [Folder]
FROM
tbSecret s
LEFT JOIN
vFolderPath fp
ON fp.FolderId = s.FolderId
WHERE NOT EXISTS
(
SELECT
1
FROM
tbGroupSecretPermission gsp
JOIN
tbGroup g
ON
g.GroupID = gsp.GroupID
JOIN
tbUserGroup ug
ON
ug.GroupID = g.GroupID
JOIN
tbUser u
ON
u.UserId = ug.UserID
WHERE
gsp.SecretID = s.SecretID
AND
(
g.IsPersonal = 1
OR
g.Active = 1
)
AND
u.[Enabled] = 1
)
AND
s.Active = 1