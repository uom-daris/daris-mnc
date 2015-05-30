##
## This script is executed  when an object is created in the PSSD namespace.
##

set asset_detail [asset.get :id $id]
set asset_model  [xvalue asset/model $asset_detail]

if { $asset_model == "om.pssd.subject" } {
	
	# Call the service that sets the mnc:subject.ID/RN element
	# for this and other (with the same subject) subject objects
	mnc.pssd.rn.subject.set :id $id :allocate true :all true :set true
}