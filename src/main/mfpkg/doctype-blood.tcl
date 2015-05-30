# Document creation script.
#
#   Server: 1047
#   Date:   Tue Sep 04 11:48:33 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:blood [version 7]
#
asset.doc.type.update :create yes :type mnc:blood \
  :label "mnc:blood" \
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
    :element -name "barcode" -type "string" -min-occurs "0" \
    < \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "storage_location" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "DNA_quality" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "DNA_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "RNA_quality" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "RNA_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "plasma_quanity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "serum_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "red_blood_cell_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "white_blood_cell_quantity" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "other_measure" -type "document" -min-occurs "0" \
    < \
      :element -name "name" -type "string" -max-occurs "1" \
      :element -name "quantity" -type "double" -max-occurs "1" \
      < \
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
        :restriction -base "string" \
        < \
          :text "false" \
        > \
      > \
    > \
   >


