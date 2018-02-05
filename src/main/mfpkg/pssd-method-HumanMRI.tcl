
# ===========================================================================
# Simple method for Human MRI acquisitions appropriate to standard RCH usage
# With no re-usable RSubject (now deprecated)
# =========================================================================== 

# Doc Type namespace
set ns mnc
#
# If Method pre-exists, action = 0 (do nothing), 1 (replace), 2 (create new)
# If creating Method, fillin - 0 (don't fill in cid allocator space), 1 (fill in cid allocator space)
#

proc createMethod_human_mri { { action 0 } { fillin 0 } } {
	set name "Standard Human MR"
	set description "Standard Human MR imaging Method (also supports SR); can be used for any project."
	#
	set margs ""
	# See if Method pre-exists
	set id [getMethodId $name]
	    
	# Set arguments based on desired action	
	set margs [setMethodUpdateArgs $id $action $fillin]
	if { $margs == "quit" } {
		return
	}
	#
	set args "${margs} \
	    :namespace pssd/methods  \
	    :name ${name} \
	    :description ${description} \
	    :subject < \
	    	:project < \
		    :public < \
			    :metadata < :definition -requirement optional mnc:subject.characteristics > \
			    :metadata < :definition -requirement mandatory mnc:subject.classification > \
		    > \
		    :private < \
			    :metadata < :definition -requirement mandatory mnc:subject.ID > \
			    :metadata < :definition -requirement mandatory mnc:subject.name > \
			    :metadata < :definition -requirement optional mnc:subject.consent > \
		    > \
	       > \
   	     > \
	    :step < \
		    :name MRI \
            :description \"Magnetic resonance acquisition\" \
            :study < \
		        :type \"Magnetic Resonance Imaging\" \
		        :dicom < :modality MR > \
		        :metadata < :definition -requirement mandatory mnc:scan > \
		    > \
	    > \
        :step < \
            :name SR \
            :description \"Structured Report document\" \
            :study < \
                :type \"Dose Report\" \
                :dicom < :modality SR > \
            > \
        >"
	set id2 [xvalue id [om.pssd.method.for.subject.update $args]]
	if { $id2 == "" } {
	   # An existng Method was updated
	   return $id
	} else {
	   # A new Method was created
	   return $id2
	}
}
