# Document creation script.
#
#   Server: 1047
#   Date:   Tue Sep 04 11:49:05 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:saliva [version 5]
#
asset.doc.type.update :create yes :type mnc:saliva \
  :label "mnc:saliva" \
  :definition < \
    :element -name "date_sample_taken" -type "date" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "date" \
      < \
        :time "false" \
      > \
    > \
    :element -name "date_sample_processed" -type "date" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "date" \
      < \
        :time "false" \
      > \
    > \
    :element -name "barcode" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "storage_location" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "DNA_quality" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "DNA_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "RNA_quality" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "RNA_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "Other_measure" -type "document" -min-occurs "0" \
    < \
      :element -name "name" -type "string" -max-occurs "1" \
      < \
        :description "Name of measure" \
      > \
      :element -name "quantity" -type "double" -max-occurs "1" \
      < \
        :description "quantity of measure" \
        :attribute -name "unit_of_measurement" -type "enumeration" -min-occurs "0" \
        < \
          :restriction -base "enumeration" \
          < \
            :dictionary "SI_units" \
          > \
        > \
      > \
      :element -name "quality" -type "string" -min-occurs "0" -max-occurs "1" \
      < \
        :description "quality of measure" \
      > \
    > \
   >


