# Document creation script.
#
#   Server: 1047
#   Date:   Wed Jul 30 16:03:02 EST 2014


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:subject.classification [version 24]
#
asset.doc.type.update :create yes :type mnc:subject.classification \
  :label "mnc:subject.classification" \
  :description "Division of research participants into groups." \
  :definition < \
    :element -name "case_control" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Whether a subject is case, control, pilot or reliability " \
      :restriction -base "enumeration" \
      < \
        :value "case" \
        :value "control" \
        :value "pilot" \
        :value "reliability" \
      > \
    > \
    :element -name "study_group" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Study group that is not necessarily explained by diagnosis (e.g., heavy long-term cannabis users v. heavy short-term cannabis users)" \
    > \
    :element -name "study_group_notes" -type "string" -min-occurs "0" -max-occurs "1" \
    :element -name "other_associated_studies" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "other studies the participant may be involved in " \
    > \
    :element -name "primary_diagnosis" -type "enumeration" -min-occurs "0" \
    < \
      :description "If entered 'case' for 'case_control', enter diagnosis for the patient (i.e., reason for recruitment into the study)." \
      :restriction -base "enumeration" \
      < \
        :dictionary "Diagnosis_Primary" \
      > \
      :attribute -name "assessment_date" -type "date" -min-occurs "0" \
      < \
        :description "Date of assessment" \
        :restriction -base "date" \
        < \
          :time "false" \
        > \
      > \
      :attribute -name "assessment_instrument" -type "string" -min-occurs "0" \
      < \
        :description "Instrument used to obtain diagnosis." \
      > \
      :attribute -name "assessment_time_point" -type "enumeration" -min-occurs "0" \
      < \
        :description "The time point for which this assessment was made" \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
      :attribute -name "current_past" -type "enumeration" -index "true" \
      < \
        :description "Specify whether the diagnosis is current or past." \
        :restriction -base "enumeration" \
        < \
          :value "current" \
          :value "past" \
          :case-sensitive "true" \
        > \
      > \
    > \
    :element -name "other-diagnosis" -type "enumeration" -min-occurs "0" \
    < \
      :description "enter diagnosis if not listed under 'diagnosis'" \
      :restriction -base "enumeration" \
      < \
        :dictionary "Diagnosis_Primary" \
      > \
      :attribute -name "assessment_date" -type "date" -min-occurs "0" \
      < \
        :description "Date of assessment" \
        :restriction -base "date" \
        < \
          :time "false" \
        > \
      > \
      :attribute -name "assessment_time_point" -type "enumeration" -min-occurs "0" \
      < \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
      :attribute -name "current_past" -type "enumeration" -index "true" \
      < \
        :restriction -base "enumeration" \
        < \
          :value "current" \
          :value "past" \
          :case-sensitive "true" \
        > \
      > \
    > \
    :element -name "diagnosis_notes" -type "string" -min-occurs "0" -max-occurs "1" \
   >