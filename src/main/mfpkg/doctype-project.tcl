# Document creation script.
#
#   Server: 101
#   Date:   Mon Aug 19 11:13:50 EST 2013
# Document: mnc:project [version 14]
#
asset.doc.type.update :create yes :type mnc:project \
  :label "mnc:project" \
  :description "A research project or study. " \
  :definition < \
    :element -name "short_name" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Study name known to investigators (e.g., 'Adolescent Development Study - Phase 1' short name = 'ADS T1')" \
    > \
    :element -name "investigator" -type "document" -index "true" \
    < \
      :description "The members of the project team." \
      :element -name "title" -type "enumeration" -min-occurs "0" -max-occurs "1" \
      < \
        :description "Title" \
        :restriction -base "enumeration" \
        < \
          :dictionary "title" \
        > \
      > \
      :element -name "first_name" -type "string" -max-occurs "1" \
      < \
        :description "The first name of the investigator" \
      > \
      :element -name "middle_name" -type "string" -min-occurs "0" -max-occurs "1" \
      < \
        :description "middle name" \
      > \
      :element -name "last_name" -type "string" -index "true" -max-occurs "1" \
      < \
        :description "last name" \
      > \
      :element -name "role" -type "enumeration" -min-occurs "0" \
      < \
        :description "The role of the investigator" \
        :restriction -base "enumeration" \
        < \
          :dictionary "investigator_role" \
        > \
      > \
      :element -name "email" -type "email-address" -min-occurs "0" \
      < \
        :description "Contact email of the investigator" \
      > \
      :element -name "URL" -type "string" -min-occurs "0" \
      :element -name "institution" -type "document" -index "true" -min-occurs "0" \
      < \
        :description "Name of the institution that the investigator is a member of." \
        :element -name "name" -type "enumeration" -min-occurs "0" -max-occurs "1" \
        < \
          :restriction -base "enumeration" \
          < \
            :dictionary "pssd.research.organization" \
          > \
        > \
        :element -name "department" -type "string" -min-occurs "0" -max-occurs "1" \
        :element -name "centre" -type "string" -index "true" -min-occurs "0" -max-occurs "1" \
        < \
          :description "If there is a Centre instead of department, or in addition to, include here" \
        > \
      > \
    > \
    :element -name "funding" -type "string" -index "true" -min-occurs "0" \
    < \
      :description "The funding body." \
      :attribute -name "ID" -type "string" -min-occurs "0" \
      < \
        :description "A funding ID if available." \
        :restriction -base "string" \
        < \
          :text "false" \
        > \
      > \
    > \
    :element -name "data_collected" -type "document" \
    < \
      :description "Type of data expected to be collected for all subjects at the given time point." \
      :element -name "time-point" -type "enumeration" -min-occurs 0 -max-occurs "1" \
      < \
        :description "The time point at which the specified data are expected to be collected" \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
      > \
      :element -name "imaging" -type "enumeration" -min-occurs "0" \
      < \
        :restriction -base "enumeration" \
        < \
          :dictionary "imaging_data_type" \
        > \
      > \
      :element -name "fMRI_task" -type "string" -min-occurs "0" \
      < \
        :description "Type of fMRI activation task" \
      > \
      :element -name "imaging_other" -type "string" -min-occurs "0" \
      < \
        :description "Fill this in if you choose 'other' for 'imaging'" \
      > \
      :element -name "clinical_data" -type "enumeration" -min-occurs "0" \
      < \
        :description "Instrument/test used to collect clinical data" \
         :restriction -base "enumeration" \
        < \
          :dictionary "Clinical_Assessments" \
        > \
      > \
      :element -name "neuropsychological_data" -type "enumeration" -min-occurs "0" \
      < \
        :description "Instrument/test used to collect neuropsychological data" \
         :restriction -base "enumeration" \
        < \
          :dictionary "Clinical_Assessments" \
        > \
      > \
      :element -name "biosamples" -type "enumeration" -min-occurs "0" \
      < \
        :description "Biosamples type" \
        :restriction -base "enumeration" \
        < \
          :value "blood" \
          :value "saliva" \
          :value "other" \
          :case-sensitive "true" \
        > \
      > \
      :element -name "Other" -type "string" -min-occurs "0" \
      < \
        :description "Other data collected" \
      > \
      :element -name "Notes" -type "string" -min-occurs "0" \
    > \
    :element -name "keyword" -type "enumeration" \
    < \
      :restriction -base "enumeration" \
      < \
        :dictionary "key_words" \
      > \
    > \
    :element -name "keyword_other" -type "string" -min-occurs "0" \
    :element -name "field_of_research" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :restriction -base "enumeration" \
      < \
        :dictionary "pssd.ANZSRC.Division-11.field-of-research" \
      > \
    > \
       :element -name "subject_selection_crteria" -type "document" -index "true" -min-occurs "0" \
      < \
        :description "Specifies the selection criteria for subjects." \
        :attribute -name "group" -type "string" -min-occurs "0" \
        < \
          :description "The group that this subject belongs to (e.g controls, 'patients-schizophrenia').  Use consistent values when setting this." \
        > \
        :element -name "inclusion" -type "string" -min-occurs "0" \
        < \
          :description "The general inclusion criteria for participants in this project" \
        > \
        :element -name "exclusion" -type "string" -min-occurs "0" \
        < \
          :description "The general exclusion criteria for participants in this project." \
        > \
      > \
    :element -name "time_point" -type "document" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Describes time points" \
      :element -name "separation" -type "integer" -min-occurs "0" -max-occurs "1" \
      < \
        :description "For longitudinal projects (in time), defines the nominal separation of time points in the given units." \
        :restriction -base "integer" \
        < \
          :minimum "0" \
        > \
        :attribute -name "unit" -type "enumeration" \
        < \
          :description "Unit of time point separation" \
          :restriction -base "enumeration" \
          < \
            :value "day" \
            :value "week" \
            :value "month" \
            :value "year" \
            :case-sensitive "true" \
          > \
        > \
      > \
      :element -name "value" -type "enumeration" -min-occurs "0" \
      < \
        :description "Specifies how the symbolic representation of a time point (from dictionary mnc.time_point) maps to real time point values for this project." \
        :restriction -base "enumeration" \
        < \
          :dictionary "time_point" \
        > \
        :attribute -name "description" -type "string" \
        < \
          :description "Describes the meaning of the symbolic value for the time point. It is strongly advised that a 'standard' syntax is used." \
        > \
      > \
    > \
   >
