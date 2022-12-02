SELECT
	isnull(Domain,ds.Name) AS 'Discovery Source / Domain'
	,ou.Path
	,ca.AccountName AS 'Account Name'
FROM tbComputerAccount ca
	INNER JOIN tbDiscoverySource ds on ca.DiscoverySourceId = ds.DiscoverySourceId
	LEFT JOIN tbDomain d ON d.DomainId = ds.DomainId
	LEFT JOIN tbOrganizationUnit ou ON ou.OrganizationUnitId = ca.OrganizationUnitId
	LEFT JOIN tbSecret s ON s.ComputerAccountId = ca.ComputerAccountId
WHERE ds.Active = 1
	AND ((d.EnableDiscovery is null) OR (d.EnableDiscovery = 1))
	AND s.ComputerAccountId IS NULL
	AND ca.OrganizationUnitId IS NOT NULL
/*	AND ou.Path = 'SpecificOU\SpecificOU'  */
GROUP BY isnull(Domain,ds.Name), ou.Path, ca.AccountName
	HAVING COUNT(ca.AccountName) > 0
ORDER BY
	1,2,3 ASC