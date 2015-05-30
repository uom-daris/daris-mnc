#
# Install the trigger script for /PSSD  namespace.  The execution script is triggered
# when objects are created in pssd namespace.  The script works out what to do with that
# event. In this case, it looks for subjects and updates the MNC Research NUmber
#
################################################################################################################################################


# Install trigger for user notification in PSSD namespace of new Subject created by the server
#

proc installPSSDSubjectTrigger { package } {

    set script        trigger-pssd-subject-create.tcl
    set scriptNS      system/triggers
    set pssdNS        pssd
    set label         [string toupper PACKAGE_$package]

    if { [xvalue exists [asset.namespace.exists :namespace $pssdNS]] == "false" } {
	  puts "Warning: PSSD namespace: ${pssdNS} does not exist."
	  return
    }

    #
    # create the trigger script asset. The content is the actual script that will be executed.
    #
    asset.create :url archive:///$script \
	   :namespace -create yes $scriptNS \
	   :label -create yes $label :label PUBLISHED \
	   :name $script
    
    # create the trigger. The trigger script will work out what to do with the creation
    # event (i.e. if it's a subject)
    asset.trigger.post.create :namespace $pssdNS :event create :script -type ref ${scriptNS}/${script}
}



### Main
source triggers-uninstall.tcl
#
installPSSDSubjectTrigger $package
