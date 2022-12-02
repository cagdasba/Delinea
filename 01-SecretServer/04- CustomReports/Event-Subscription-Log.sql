SELECT TOP 1000 
aud.EventTime,
aud.EventSubject,
aud.EventNote,
aud.EventDetails,
aud.IPAddress,
					tbEventEntityType.EventEntityType,
					tbEventAction.EventAction,
					vUserDisplayName.DisplayName AS ByUser
					FROM tbEventAudit aud WITH (NOLOCK)
					INNER JOIN tbEventEntityType	WITH (NOLOCK)	
					ON 		aud.EventEntityTypeId = tbEventEntityType.EventEntityTypeId
					INNER JOIN vUserDisplayName WITH (NOLOCK)
					ON		aud.UserId = vUserDisplayName.UserId
					INNER JOIN tbEventAction WITH (NOLOCK)	 	
					ON 		aud.EventActionId = tbEventAction.EventActionId
					WHERE EXISTS(SELECT * FROM tbEventSubscription s WITH (NOLOCK)
						INNER JOIN dbo.tbEventSubscriptionEntityAction ea WITH (NOLOCK)
							ON s.EventSubscriptionId = ea.EventSubscriptionId
						WHERE s.OrganizationId = aud.OrganizationId
						AND ea.EventEntityTypeId = aud.EventEntityTypeId 
						AND ea.EventActionId = aud.EventActionId
						AND (ea.ItemId = aud.ItemId OR ea.ItemId IS NULL)
						AND (ea.ContainerId = aud.ContainerId OR ea.ContainerId IS NULL)
						AND s.Active = 1
						AND EXISTS(SELECT * FROM dbo.tbEventSubscriptionGroup g WITH (NOLOCK)
							INNER JOIN tbUserGroup ug WITH (NOLOCK)
								ON g.GroupId = ug.GroupId
							INNER JOIN tbUser u WITH (NOLOCK)
								ON ug.UserId = u.UserId
							INNER JOIN tbGroup g2 WITH (NOLOCK)
								ON g.GroupId = g2.GroupId
							WHERE u.UserId = #user
							AND g.EventSubscriptionId = s.EventSubscriptionId
							AND u.OrganizationId = aud.OrganizationId
							AND (g2.Active = 1 OR g2.IsPersonal = 1)
							)
						)
				ORDER BY aud.EventAuditId DESC