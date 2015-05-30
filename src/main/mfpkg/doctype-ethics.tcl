# Document creation script.
#
#   Server: 1047
#   Date:   Fri Oct 12 17:36:25 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:ethics [version 2]
#
asset.doc.type.update :create yes :type mnc:ethics \
  :label "mnc:ethics_new" \
  :definition < \
    :element -name "Project_ethics" -type "document" \
    < \
      :attribute -name "Organisation" -type "enumeration" -index "true" \
      < \
	:restriction -base "enumeration" \
	< \
	  :dictionary "ethics_organization" \
	> \
      > \
      :attribute -name "Organisation_other" -type "string" -min-occurs "0" \
      < \
	:description "Enter organisation if not listed above" \
      > \
      :attribute -name "Title" -type "string" \
      < \
	:description "Project title as known by the ethics organisation" \
      > \
      :attribute -name "ID" -type "string" \
      < \
	:description "ID number as provided by ethics organisation" \
      > \
    > \
    :element -name "Databank_ethics" -type "document" -max-occurs "1" \
    < \
      :element -name "MRI_Clinical" -type "enumeration" -max-occurs "1" \
      < \
	:description "As per CIA preference, what usage will be allowed for the MRI/Clinical data?" \
	:restriction -base "enumeration" \
	< \
	  :dictionary "ethics_usage" \
	> \
      > \
      :element -name "Biosamples" -type "enumeration" -max-occurs "1" \
      < \
	:description "As per CIA preference, what usage will be allowed for the biosamples data?" \
	:restriction -base "enumeration" \
	< \
	  :dictionary "ethics_usage" \
	> \
      > \
    > \
   >