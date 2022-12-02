SELECT 
                       a.DateRecorded AS [Date Recorded],
                       upn.displayname AS [User],
                       ISNULL(fp.FolderPath, N'No folder assigned') as [Folder Path],
                       s.secretname As [Secret Name],
                       a.Action,
                       a.Notes,
                       a.ipaddress AS [IP Address],
                       g.GroupName
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
                       inner join tbUserGroup ug WITH (NOLOCK)
                                on u.UserId = ug.UserId 
                       inner join tbGroup  g  WITH (NOLOCK)
                        on ug.GroupId = g.Groupid   
            WHERE a.DateRecorded >= #StartDate
                       AND
                       a.DateRecorded <= #EndDate     
     ORDER BY               1 DESC,7,6,5,4,3,2