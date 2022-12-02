SELECT 
			CASE 
				WHEN PasswordComplianceCode = 0 THEN 'Pending'
				WHEN PasswordComplianceCode = 1 THEN 'Compliant'
				WHEN PasswordComplianceCode = 2 THEN 'Non-Compliant'
			END AS PasswordCompliance,
			COUNT(*) AS Total
			FROM tbSecret       
				INNER JOIN tbSecretType st ON tbSecret.SecretTypeId = st.SecretTypeId
				INNER JOIN tbSecretField sf ON st.SecretTypeID = sf.SecretTypeID
				INNER JOIN tbPasswordRequirement pr ON sf.PasswordRequirementId = pr.PasswordRequirementId
				WHERE st.Organizationid = #ORGANIZATION
				AND tbSecret.Active = 1
				AND sf.IsPassword = 1
				AND sf.Active = 1
			GROUP BY PasswordComplianceCode