# Document creation script.
#
#   Server: 101
#   Date:   Thu Aug 29 13:57:12 EST 2013


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:subject.ID [version 4]
#
asset.doc.type.update :create yes :type mnc:subject.ID \
  :label "mnc:subject.ID" \
  :description "Identification number of the subject." \
  :definition < \
    :element -name "RN" -type "integer" -index "true" -min-occurs "0" -max-occurs "1" \
    < \
      :description "RN (Research Number) is a unique identification number allocated to each research participant by MNC." \
      :restriction -base "integer" \
      < \
        :minimum "1" \
      > \
      :attribute -name "cid" -type "citeable-id" -min-occurs "0" \
      < \
        :description "The citeable identifier from which the RN (child part) is derived" \
      > \
    > \
    :element -name "non_MNC_ID" -type "document" -min-occurs "0" \
    < \
      :description "Identification number allocated to the subject other than the RN, that is, an ID that is assigned to the subject before the data is passed to MNC for RN allocation. " \
      :element -name "UR" -type "integer" -index "true" -min-occurs "0" \
      < \
        :description "ID allocated by the hospital." \
        :restriction -base "integer" \
        < \
          :minimum "1" \
        > \
        :attribute -name "provider" -type "enumeration" -min-occurs "0" \
        < \
          :description "The provider who generates the UR (usually a hospital)" \
          :restriction -base "enumeration" \
          < \
            :dictionary "UR_provider" \
          > \
        > \
      > \
      :element -name "project_specific_subject_ID" -type "document" -min-occurs "0" \
      < \
        :description "ID assigned by each project to its research participant. " \
        :element -name "project_specific_ID_type" -type "string" -min-occurs "0" -max-occurs "1" \
        < \
          :description "e.g., PACE_CRF, EPPIC800_ID" \
        > \
        :element -name "ID" -type "string" -index "true" -min-occurs "0" -max-occurs "1" \
        < \
          :description "ID number or code" \
        > \
      > \
    > \
   >