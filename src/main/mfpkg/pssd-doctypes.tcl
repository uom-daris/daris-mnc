#=============================================================================
# Creates MNC Document Types in namespace "mnc"
#=============================================================================
proc createPSSDCoreDocTypes { } {

	source doctype-blood.tcl
	source doctype-ethics.tcl
	source doctype-project.tcl
	source doctype-publication.tcl
	source doctype-saliva.tcl
	source doctype-scan.tcl
	source doctype-subject.ID.tcl
	source doctype-subject.characteristics.tcl
	source doctype-subject.classification.tcl
	source doctype-subject.consent.tcl
	source doctype-subject.name.tcl
}

#============================================================================#
proc destroyPSSDCoreDocTypes { } {

	set doctypes { "mnc:blood" "mnc:ethics" "mnc:project" "mnc:publication" \
	    "mnc:saliva" "mnc:scan" "mnc:subject.ID" "mnc:subject.characteristics" \
	    "mnc:subject.classification" "mnc:subject.consent" "mnc:subject.name" }
	foreach doctype $doctypes {
     		destroyDocType $doctype "true"
	}

}

#============================================================================#
#                                                                            #
#============================================================================#
createPSSDCoreDocTypes
