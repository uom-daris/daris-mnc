# Document creation script.
#
#   Server: 101
#   Date:   Wed Aug 28 16:43:32 EST 2013


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:subject.consent [version 9]
#
asset.doc.type.update :create yes :type mnc:subject.consent \
  :label "mnc:subject.consent" \
  :description "Consent from the subject on the use of his/her data." \
  :definition < \
    :element -name "conset_withdrawn" -type "document" -min-occurs "0" -max-occurs "1" \
    < \
      :description "When subject withdraws consent from participation in project." \
      :attribute -name "date" -type "date" -min-occurs "0" \
      < \
        :description "The date when the subject withdraws consent." \
        :restriction -base "date" \
        < \
          :time "false" \
        > \
      > \
      :element -name "time_point" -type "enumeration" -min-occurs "0" -max-occurs "1" \
      < \
        :description "The time pint during which the subject withdraw consent." \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
      :element -name "notes" -type "string" -min-occurs "0" \
      < \
        :description "Notes about why consent was withdrawn." \
      > \
      :element -name "type" -type "enumeration" -min-occurs "0" -max-occurs "1" \
      < \
        :description "The type of withdrawal" \
        :restriction -base "enumeration" \
        < \
          :value "participation only" \
          :value "participation and data" \
          :case-sensitive "true" \
        > \
      > \
    > \
    :element -name "databank_MRI_consent" -type "enumeration" -min-occurs "0" \
    < \
      :description "Has the participant provided specific consent for their MRI/clinical data to be included in the databank?" \
      :restriction -base "enumeration" \
      < \
        :dictionary "subject_consent" \
      > \
      :attribute -name "time_point" -type "enumeration" -min-occurs "0" \
      < \
        :description "The time point during which the subject gave their consent" \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
    > \
    :element -name "databank_bio_consent" -type "enumeration" -min-occurs "0" \
    < \
      :description "Has the participant provided specific consent for their biological (i.e., saliva/blood) data to be included in the databank?" \
      :restriction -base "enumeration" \
      < \
        :dictionary "subject_consent" \
      > \
      :attribute -name "time_point" -type "enumeration" -min-occurs "0" \
      < \
        :description "The time point during which the subject gave their consent" \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
    > \
    :element -name "future_related_studies" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Has the subject given consent to be contacted for future related studies" \
      :restriction -base "enumeration" \
      < \
        :dictionary "subject_consent" \
      > \
      :attribute -name "time_point" -type "enumeration" -min-occurs "0" \
      < \
        :description "The time point during which the subject gave their consent." \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
    > \
    :element -name "other_MNC_studies" -type "enumeration" -min-occurs "0" \
    < \
      :description "Has the subject given consent to be contacted for future MNC studies" \
      :restriction -base "enumeration" \
      < \
        :dictionary "subject_consent" \
      > \
      :attribute -name "time_point" -type "enumeration" -min-occurs "0" \
      < \
        :description "The time point during which the subject gave their consent" \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
    > \
   >
