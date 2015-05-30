# Document creation script.
#
#   Server: 1047
#   Date:   Tue Sep 04 11:49:47 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:subject.characteristics [version 9]
#
asset.doc.type.update :create yes :type mnc:subject.characteristics \
  :label "mnc:subject.characteristics" \
  :description "Information of a research participant" \
  :definition < \
    :element -name "gender" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "The gender of the subject" \
      :restriction -base "enumeration" \
      < \
        :value "female" \
        :value "male" \
        :value "other" \
        :value "unknown" \
      > \
    > \
    :element -name "DOB" -type "date" -index "true" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Date of Birth of the subject in DD-MMM-YYYY" \
      :restriction -base "date" \
      < \
        :time "false" \
      > \
    > \
    :element -name "handedness" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Handedness of the subject." \
      :restriction -base "enumeration" \
      < \
        :value "left" \
        :value "mixed" \
        :value "right" \
        :value "unknown" \
      > \
    > \
    :element -name "subject_change_notes" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "notes from Anthony Ang" \
    > \
   >


