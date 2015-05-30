# Document creation script.
#
#   Server: 1047
#   Date:   Tue Sep 04 11:50:28 EST 2012


if { [ xvalue exists [asset.doc.namespace.exists :namespace "mnc"]] == "false" } {
  asset.doc.namespace.update :create true :namespace mnc
}

# Document: mnc:subject.name [version 2]
#
asset.doc.type.update :create yes :type mnc:subject.name \
  :label "mnc:subject.name" \
  :description "Name of the research participant." \
  :definition < \
    :element -name "first_name" -type "string" -min-occurs 1 -max-occurs infinity \
    < \
      :description "First name of the subject" \
      :attribute -name "first_name_type" -type "enumeration" -index "true" -min-occurs "0" \
      < \
        :description "Type of the first name e.g. abbreviated/long form, changed name, etc." \
        :restriction -base "enumeration" \
        < \
          :value "abbreviated first name" \
          :value "current name" \
          :value "fully-spelt first name" \
          :value "old name" \
          :value "other" \
        > \
      > \
    > \
    :element -name "surname" -type "string" -min-occurs 1 -max-occurs infinity \
    < \
      :description "Surname of the subject." \
      :attribute -name "surname_type" -type "enumeration" -index "true" -min-occurs "0" \
      < \
        :description "Maiden name, married name, changed surname, etc." \
        :restriction -base "enumeration" \
        < \
          :value "current surname" \
          :value "maiden surname" \
          :value "married surname" \
          :value "old surname" \
          :value "other" \
        > \
      > \
    > \
    :element -name "alias" -type "string" -min-occurs "0" -max-occurs infinity \
    < \
      :description "Alias of the subject - other known name, changed name, maiden name, married name, etc." \
      :attribute -name "alias_type" -type "enumeration" -index "true" -min-occurs "0" \
      < \
        :description "The type of the alias, whether it is a middle name, nickname, etc." \
        :restriction -base "enumeration" \
        < \
          :value "middle name" \
          :value "nickname" \
          :value "other" \
        > \
      > \
    > \
   >


