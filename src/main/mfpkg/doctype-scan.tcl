#
#   Server: 101
#   Date:   Mon Aug 19 13:10:22 EST 2013
# Document: mnc:scan [version 2]
#
asset.doc.type.update :create yes :type mnc:scan \
  :label "mnc:scan" \
  :description "MRI scan." \
  :definition < \
    :element -name "MRI_number" -type "integer" -index "true" -min-occurs "0" -max-occurs "1" \
    < \
      :description "A unique 7-digits number assigned to each scan by MNC." \
      :restriction -base "integer" \
      < \
        :minimum "1000001" \
        :maximum "1999999" \
      > \
    > \
    :element -name "date" -type "date" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Date on which the MRI scan was acquired." \
      :restriction -base "date" \
      < \
        :time "false" \
      > \
    > \
    :element -name "date_from_DICOM" -type "date" -min-occurs "0" -max-occurs "1" \
    :element -name "site" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Scanning site from which the MRI scan was acquired." \
      :restriction -base "enumeration" \
      < \
        :dictionary "scanner_site" \
      > \
    > \
    :element -name "magnetic_field" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Magnetic field strength (Tesla) of the scanner." \
      :attribute -name "unit" -type "enumeration" -index "true" \
      < \
        :description "Unit for magnetic field strength is Tesla" \
        :restriction -base "enumeration" \
        < \
          :value "Tesla" \
          :case-sensitive "true" \
        > \
      > \
    > \
    :element -name "CD_number" -type "integer" -min-occurs "0" \
    < \
      :description "A unique number assigned by MNC to the CD containing the scan." \
      :restriction -base "integer" \
      < \
        :minimum "1" \
      > \
    > \
    :element -name "tape_number" -type "integer" -min-occurs "0" \
    < \
      :description "The number of the magnetic tape containing the scan." \
    > \
    :element -name "directory" -type "string" -min-occurs "0" \
    < \
      :description "The file directory on which the scan is located on MNC's computer system." \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "sequences" -type "enumeration" -min-occurs "0" \
    < \
      :description "The sequence acquired during the scan e.g. T1, T2, DTI, fMRI and so on." \
      :restriction -base "enumeration" \
      < \
        :dictionary "MRI_sequence" \
      > \
      :attribute -name "sequence_details" -type "string" -index "true" -min-occurs "0" \
      < \
        :description "Details of the sequence." \
      > \
    > \
    :element -name "other_sequence" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Complete if 'other' was selected for 'sequence'" \
    > \
    :element -name "quality" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "The quality of the scan." \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "scan_information" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Information/notes about the scan" \
      :restriction -base "string" \
      < \
        :text "false" \
      > \
    > \
    :element -name "time_point" -type "enumeration" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Defines, for longitudinal projects, what time point the acquisition is for.  See also mnc:project/time_point_separation." \
      :restriction -base "enumeration" \
      < \
        :dictionary "time_point" \
      > \
    > \
    :element -name "age" -type "float" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Age of the participant at the scan date." \
      :restriction -base "float" \
      < \
        :minimum "0" \
      > \
    > \
    :element -name "other_study_details" -type "string" -min-occurs "0" -max-occurs "1" \
    < \
      :description "Additional notes for the study" \
    > \
   >