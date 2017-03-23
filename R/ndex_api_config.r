################################################################################
## Authors:
##   Florian Auer [florian.auer@med.uni-goettingen.de]
##
## History:
##   Created on 28 November 2016 by Auer
##   Switched to yml file on 02 Februar 2017 by Auer
## 	
## Description:
##   Contains API configuration for connecting to NDEx servers
## 	
## Note:
##   This file is automatically generated from a YAML file!
################################################################################


#' NDEx server api configuration
#' 
#' This nested list contains the url and methods for accessing the NDEx server via its REST full api
#' It contains specifications for NDEx server api version 1.3 and 2.0. The default api is specified by 'defaultVersion'
#' If possible, the version 2.0 should be used
#' Own configurations must contain a 'version' entry!
#' 
#' @return Nested list resembling the NDEx server REST API structure
#' @export
ndex.api.config = list(
	defaultVersion="Version_2.0",
	Version_2.0=list(
		version="2.0",
		connection=list(
			description="URL of the NDEx server",
			host="www.ndexbio.org",
			api="/v2"
		),
		api=list(
			serverStatus=list(
				description="Get Server Status",
				url="/admin/status",
				method="GET"
			),
			user=list(
				authenticate=list(
					description="Authenticate a User",
					url="/user?valid=true",
					method="GET",
					params=list(
						valid=list(
							method="parameter",
							tag="valid",
							default="true"
						)
					)
				),
				create=list(
					description="Create a new user",
					url="/user",
					method="POST"
				),
				delete=list(
					description="Deletes the authenticated user, removing any other objects in the database that depend on the user",
					url="/user/#USERID#",
					method="DELETE",
					params=list(
						user=list(
							tag="#USERID#",
							method="replace"
						)
					)
				),
				update=list(
					description="Updates the authenticated user based on the serialized user object in the PUT data",
					url="/user/#USERID#",
					method="PUT",
					params=list(
						user=list(
							tag="#USERID#",
							method="replace"
						)
					)
				),
				get=list(
					byName=list(
						description="Get User By userName",
						url="/user",
						method="GET",
						params=list(
							userName=list(
								method="parameter",
								tag="username"
							)
						)
					),
					byId=list(
						description="Get User By UUID",
						url="/user/#USERID#",
						method="GET",
						params=list(
							user=list(
								method="replace",
								tag="#USERID#"
							)
						)
					)
				),
				password=list(
					change=list(
						description="Changes the authenticated user’s password to the new password",
						url="/user/#USERID#/password",
						method="PUT",
						params=list(
							user=list(
								method="replace",
								tag="#USERID#"
							)
						)
					),
					mail=list(
						description="Causes a new password to be generated for the given user account and then emailed to the user’s emailAddress",
						url="/user/#USERID#/password",
						method="PUT",
						params=list(
							user=list(
								method="replace",
								tag="#USERID#"
							),
							forgot=list(
								method="parameter",
								tag="forgot",
								default="true"
							)
						)
					)
				),
				verify=list(
					description="Verify a User with verificationCode",
					url="/user/#USERID#/verification",
					method="GET",
					params=list(
						user=list(
							tag="#USERID#",
							method="replace"
						),
						code=list(
							method="parameter",
							tag="verificationCode"
						)
					)
				),
				group=list(
					get=list(
						description="Get User’s Permissions in Group",
						url="/user/#USERID#/membership",
						method="GET",
						params=list(
							user=list(
								tag="#USERID#",
								method="replace"
							),
							group=list(
								method="parameter",
								tag="groupid"
							)
						)
					),
					list=list(
						description="List Groups for which a user has the specified permission types",
						url="/user/#USERID#/membership",
						method="GET",
						params=list(
							user=list(
								tag="#USERID#",
								method="replace"
							),
							type=list(
								method="parameter",
								tag="type",
								optional=TRUE
							),
							start=list(
								method="parameter",
								tag="start",
								optional=TRUE
							),
							size=list(
								method="parameter",
								tag="size",
								optional=TRUE
							)
						)
					)
				),
				permission=list(
					get=list(
						description="Get User’s Permission for Network",
						url="/user/#USERID#/permission",
						method="GET",
						params=list(
							user=list(
								tag="#USERID#",
								method="replace"
							),
							network=list(
								method="parameter",
								tag="networkid",
								optional=TRUE
							),
							directonly=list(
								method="parameter",
								tag="directonly",
								default="false"
							)
						)
					),
					list=list(
						description="List User’s Network Permissions",
						url="/user/#USERID#/permission?permission={permission}&start={startPage}&size={pageSize}&directonly={true|false}",
						method="GET",
						params=list(
							user=list(
								tag="#USERID#",
								method="replace"
							),
							permission=list(
								method="parameter",
								tag="permission",
								optional=TRUE
							),
							start=list(
								method="parameter",
								tag="start",
								optional=TRUE
							),
							size=list(
								method="parameter",
								tag="size",
								optional=TRUE
							),
							directonly=list(
								method="parameter",
								tag="directonly",
								default="false"
							)
						)
					)
				),
				showcase=list(
					description="Get User’s Showcase Networks",
					url="/user/#USERID#/showcase",
					method="GET",
					params=list(
						user=list(
							tag="#USERID#",
							method="replace"
						)
					)
				),
				networksummary=list(
					description="Verify a User with verificationCode",
					url="/user/#USERID#/networksummary",
					method="GET",
					params=list(
						user=list(
							tag="#USERID#",
							method="replace"
						)
					)
				)
			),
			network=list(
				create=list(
					description="Create a CX Network",
					url="/network",
					method="POST"
				),
				update=list(
					description="Update a Network",
					url="/network/#NETWORKID#",
					method="PUT",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				delete=list(
					description="Delete a Network",
					url="/network/#NETWORKID#",
					method="DELETE",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				get=list(
					description="Get Complete Network in CX format",
					url="/network/#NETWORKID#",
					method="GET",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				summary=list(
					get=list(
						description="Get Network Summary",
						url="/network/#NETWORKID#/summary",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				sample=list(
					set=list(
						description="Get Network Summary",
						url="/network/#NETWORKID#/sample",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					),
					get=list(
						description="Set Network Sample",
						url="/network/#NETWORKID#/sample",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				aspect=list(
					getMetaData=list(
						description="Get Network CX Metadata Collection",
						url="/network/#NETWORKID#/aspect",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					),
					getMetaDataByName=list(
						description="Get Network Aspect Metadata",
						url="/network/#NETWORKID#/aspect/#ASPECT#/metadata",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							aspect=list(
								tag="#ASPECT#",
								method="replace"
							)
						)
					),
					get=list(
						description="Get a Network Aspect As CX",
						url="/network/#NETWORKID#/aspect/#ASPECT#",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							aspect=list(
								tag="#ASPECT#",
								method="replace"
							),
							size=list(
								tag="size",
								method="parameter",
								optional=TRUE
							)
						)
					),
					update=list(
						description="Update an Aspect of a Network",
						url="/network/#NETWORKID#/aspect/#ASPECT#",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							aspect=list(
								tag="#ASPECT#",
								method="replace"
							)
						)
					)
				),
				permission=list(
					get=list(
						description="Get All Permissions on a Network",
						url="/network/#NETWORKID#/permission",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							type=list(
								tag="type",
								method="parameter"
							),
							permission=list(
								tag="permission",
								method="parameter",
								optional=TRUE
							),
							start=list(
								tag="start",
								method="parameter",
								optional=TRUE
							),
							size=list(
								tag="size",
								method="parameter",
								optional=TRUE
							)
						)
					),
					update=list(
						description="Update Network Permission",
						url="/network/#NETWORKID#/permission",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							user=list(
								tag="userid",
								method="parameter",
								optional=TRUE
							),
							group=list(
								tag="groupid",
								method="parameter",
								optional=TRUE
							),
							permission=list(
								tag="permission",
								method="parameter"
							)
						)
					),
					delete=list(
						description="Delete Network Permission",
						url="/network/#NETWORKID#/permission",
						method="DELETE",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							user=list(
								tag="userid",
								method="parameter",
								optional=TRUE
							),
							group=list(
								tag="groupid",
								method="parameter",
								optional=TRUE
							)
						)
					)
				),
				profile=list(
					update=list(
						description="Update Network Profile",
						url="/network/#NETWORKID#/profile",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				systemproperties=list(
					set=list(
						description="Set Network System Properties",
						url="/network/#NETWORKID#/systemproperty",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				properties=list(
					set=list(
						description="Set Network Properties",
						url="/network/#NETWORKID#/properties",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				provenance=list(
					set=list(
						description="Set Network Provenance",
						url="/network/#NETWORKID#/provenance",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					),
					get=list(
						description="Get Network Provenance",
						url="/network/#NETWORKID#/provenance",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				)
			),
			search=list(
				user=list(
					description="Search users",
					url="/search/user",
					method="POST",
					params=list(
						start=list(
							tag="start",
							method="parameter",
							default="0"
						),
						size=list(
							tag="size",
							method="parameter",
							default="100"
						)
					)
				),
				group=list(
					description="Search groups",
					url="/search/group",
					method="POST",
					params=list(
						start=list(
							tag="start",
							method="parameter",
							default="0"
						),
						size=list(
							tag="size",
							method="parameter",
							default="100"
						)
					)
				),
				network=list(
					search=list(
						description="Search network",
						url="/search/network",
						method="POST",
						params=list(
							start=list(
								tag="start",
								method="parameter",
								default="0"
							),
							size=list(
								tag="size",
								method="parameter",
								default="100"
							)
						)
					),
					neighborhood=list(
						description="Query Network As CX",
						url="/search/network/#NETWORKID#/query",
						method="POST",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							size=list(
								tag="size",
								method="parameter",
								optional=TRUE
							)
						)
					)
				)
			)
		)
	),
	Version_1.3=list(
		version="1.3",
		connection=list(
			description="URL of the NDEx server",
			host="www.ndexbio.org",
			api="/rest"
		),
		api=list(
			serverStatus=list(
				description="Get Server Status",
				url="/admin/status",
				method="GET"
			),
			user=list(
				authenticate=list(
					description="Authenticate a User",
					url="/user/authenticate",
					method="GET"
				)
			),
			network=list(
				create=list(
					description="Create a CX Network",
					url="/network/asCX",
					method="POST"
				),
				update=list(
					description="Update a Network",
					url="/network/asCX/#NETWORKID#",
					method="PUT",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				delete=list(
					description="Delete a Network",
					url="/network/#NETWORKID#",
					method="DELETE",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				get=list(
					description="Get Complete Network in CX format",
					url="/network/#NETWORKID#/asCX",
					method="GET",
					params=list(
						network=list(
							tag="#NETWORKID#",
							method="replace"
						)
					)
				),
				summary=list(
					get=list(
						description="Get Network Summary",
						url="/network/#NETWORKID#",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				aspect=list(
					getMetaData=list(
						description="Get Network CX Metadata Collection",
						url="/network/#NETWORKID#/metadata",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					),
					get=list(
						description="Get a Network Aspect As CX",
						url="/network/#NETWORKID#/aspect/#ASPECT#",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							aspect=list(
								tag="#ASPECT#",
								method="replace"
							),
							size=list(
								method="append",
								optional=TRUE
							)
						)
					)
				),
				permission=list(
					get=list(
						description="Get All Permissions on a Network",
						url="/network/#NETWORKID#/user/#PERMISSION#",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							permission=list(
								tag="#PERMISSION#",
								method="replace",
								default="ALL"
							),
							start=list(
								method="append",
								default="0"
							),
							size=list(
								method="append",
								default="1000"
							)
						)
					),
					update=list(
						description="Update Network Permission",
						url="/network/#NETWORKID#/member/user/#USERID#",
						method="POST",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							user=list(
								tag="#USERID#",
								method="replace"
							)
						)
					),
					delete=list(
						description="Delete Network Permission",
						url="/network/#NETWORKID#/member/user/#USERID#",
						method="DELETE",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							user=list(
								tag="#USERID#",
								method="replace"
							)
						)
					)
				),
				profile=list(
					update=list(
						description="Update Network Profile",
						url="/network/#NETWORKID#/summary",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				systemproperties=list(
					set=list(
						description="Set Network System Properties",
						url="/network/#NETWORKID#/setFlag/readOnly=#VALUE#",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							),
							readOnly=list(
								tag="#VALUE#",
								method="replace"
							)
						)
					)
				),
				properties=list(
					set=list(
						description="Set Network Properties",
						url="/network/#NETWORKID#/properties",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				),
				provenance=list(
					set=list(
						description="Set Network Provenance",
						url="/network/#NETWORKID#/provenance",
						method="PUT",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					),
					get=list(
						description="Get Network Provenance",
						url="/network/#NETWORKID#/provenance",
						method="GET",
						params=list(
							network=list(
								tag="#NETWORKID#",
								method="replace"
							)
						)
					)
				)
			),
			search=list(
				user=list(
					description="Search users",
					url="/user/search",
					method="POST",
					params=list(
						start=list(
							method="append",
							default="0"
						),
						size=list(
							method="append",
							default="100"
						)
					)
				),
				group=list(
					description="Search groups",
					url="/group/search",
					method="POST",
					params=list(
						start=list(
							method="append",
							default="0"
						),
						size=list(
							method="append",
							default="100"
						)
					)
				),
				network=list(
					search=list(
						description="Search network",
						url="/network/textsearch",
						method="POST",
						params=list(
							start=list(
								method="append",
								default="0"
							),
							size=list(
								method="append",
								default="100"
							)
						)
					),
					neighborhood=list(
						description="Query Network As CX",
						url="/network/#NETWORKID#/asCX/query",
						method="POST"
					)
				)
			)
		)
	)
)
