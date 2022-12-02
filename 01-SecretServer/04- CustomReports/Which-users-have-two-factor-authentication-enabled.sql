SELECT
	vUserDisplayName.DisplayName
	,CASE
		WHEN tbUser.RadiusTwoFactor = 1 THEN 'RADIUS'
		WHEN tbUser.PinCode = 1 THEN 'Email Pin Code'
		ELSE 'None'
	END AS 'Two Factor Method'
FROM
	tbUser WITH (NOLOCK)
INNER JOIN vUserDisplayName WITH (NOLOCK)
	ON tbUser.UserId = vUserDisplayName.UserId
WHERE
	tbUser.Enabled = 1