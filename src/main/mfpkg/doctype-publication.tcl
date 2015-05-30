# Document creation script.
#
#   Server: 1047
#   Date:   Tue Sep 04 11:48:55 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:publication [version 2]
#
asset.doc.type.update :create yes :type mnc:publication \
  :label "mnc:publication" \
  :description "Publication from the dataset" \
  :definition < \
    :element -name "description" -type "string" -max-occurs "1" \
    < \
      :description "Description of the publication." \
    > \
   >


