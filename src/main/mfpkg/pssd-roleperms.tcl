# Documemt Type access
set pssd_doc_perms { { document mnc:blood ACCESS } \
			{ document mnc:blood PUBLISH } \
			{ document mnc:ethics ACCESS } \
			{ document mnc:ethics PUBLISH } \
			{ document mnc:project ACCESS } \
			{ document mnc:project PUBLISH } \
			{ document mnc:publication ACCESS } \
			{ document mnc:publication PUBLISH } \
			{ document mnc:saliva ACCESS } \
			{ document mnc:saliva PUBLISH } \
			{ document mnc:scan ACCESS } \
			{ document mnc:scan PUBLISH } \
			{ document mnc:subject.ID ACCESS } \
			{ document mnc:subject.ID PUBLISH } \
			{ document mnc:subject.characteristics ACCESS } \
			{ document mnc:subject.characteristics PUBLISH } \
			{ document mnc:subject.classification ACCESS } \
			{ document mnc:subject.classification PUBLISH } \
			{ document mnc:subject.consent ACCESS } \
			{ document mnc:subject.consent PUBLISH } \
			{ document mnc:subject.name ACCESS } \
			{ document mnc:subject.name PUBLISH } }

# Service access
set pssd_svc_perms { { service mnc.pssd.* ACCESS } \
		     { service mnc.pssd.* MODIFY } \
                     { service server.database.describe ACCESS } }

# Role for user of this package; grant this to your users.
set domain_model_user_role        mnc.pssd.model.user
createRole     $domain_model_user_role
grantRolePerms $domain_model_user_role $pssd_doc_perms
grantRolePerms $domain_model_user_role $pssd_svc_perms

# Grant end users the right to access the mnc document namespace
actor.grant :name  $domain_model_user_role :type role :perm < :resource -type document:namespace mnc :access ACCESS >

# This specialized service needs to be able to access all objects
actor.grant :name mnc.pssd.rn.subject.set :type plugin:service :role -type role system-administrator
 
# DICOM server permissions 
# This is the role to grant your DICOM proxy users
set domain_dicom_ingest_role      mnc.pssd.dicom-ingest
createRole     $domain_dicom_ingest_role

# DOcument Types
# Grant DICOM users the right to access the mnc document namespace
actor.grant :name  $domain_dicom_ingest_role :type role :perm < :resource -type document:namespace mnc :access ACCESS >

# Set the permissions that allow the mnc.pssd.subject.meta.set service to be called
# and used by the DICOM server framework
set dicom_ingest_doc_perms { { document mnc:subject.characteristics ACCESS } \
			     { document mnc:subject.characteristics PUBLISH } \
                             { document mnc:scan ACCESS } \
			     { document mnc:scan PUBLISH } }
			     
# Grant permissions to dicom role
grantRolePerms $domain_dicom_ingest_role $dicom_ingest_doc_perms

# Service that allows the DICOM server to set domain-specific meta-data
set dicom_ingest_service_perms { { service mnc.pssd.object.meta.set MODIFY } }
#
# Grant this role to the DICOM server proxy user
grantRolePerms $domain_dicom_ingest_role $dicom_ingest_service_perms

