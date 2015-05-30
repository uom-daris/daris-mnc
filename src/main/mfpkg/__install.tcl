# Supply arguments with 
#  package.install :arg -name <arg name> <value>
#
# Arguments:
#     studyTypes - If set to false, does not add the mnc-pssd Study type definitions.
#                  Defaults to true.
#           model - Set to false to not make any changes to the object model such as what meta-data
#                   are registered with the data model.  Defaults to true.
#           fillIn - Set to true to fill in CID space for Methods when creating
#           action - If Method pre-exists, action = 0 (do nothing), 1 (replace), 2 (create new)
#
# ============================================================================
# Check if server version is no less than the required version
# ============================================================================

source old-release-cleanup.tcl

# ============================================================================
# Include the utils.tcl functions
# ============================================================================
source utils.tcl

#============================================================================
# Create dictionaries
#
# Note: it is created first because services may, when being reloaded, 
#       instantiate classes which specify dictionaries
#============================================================================
source pssd-dictionaries.tcl
createUpdatePSSDDicts

#============================================================================
# Add our Study Types. The command-line arguments allows you to choose to
# not add our study types, so other sites can fully define their own.
#
# Really just a dictionary, but we keep it logically separate
#============================================================================
set addStudyTypes 1
if { [info exists studyTypes ] } {
    if { $studyTypes == "false" } {
	set addStudyTypes 0
    }
}
if { $addStudyTypes == 1 } {
   source pssd-studytypes.tcl
   create_PSSD_StudyTypes
}

# ============================================================================
# Install plugins
# ============================================================================
set plugin_label      [string toupper PACKAGE_$package]
set plugin_namespace  mflux/plugins
set plugin_zip        daris-mnc-plugin.zip
set plugin_jar        daris-mnc-plugin.jar
set module_class      mnc.mf.plugin.pssd.PSSDPluginModule
set plugin_libs       { daris-commons.jar }
loadPlugin $plugin_namespace $plugin_zip $plugin_jar $module_class $plugin_label $plugin_libs
srefresh

#=============================================================================
# Create document types in own namespace
#=============================================================================
source pssd-doctypes.tcl

#=============================================================================
# Method directives
#=============================================================================

# Method fill-in
set fillInMethods 1
if { [info exists fillIn ] } {
    if { $fillIn == "false" } {
	  set fillInMethods 0
    }
}

# Method action
set methodAction 0
if { [info exists action ] } {
  set methodAction $action
}

#=============================================================================
# Create Human method
#=============================================================================
source pssd-method-HumanMRI.tcl
createMethod_human_mri $methodAction $fillInMethods

#=============================================================================
# Register doc types with the data model
#=============================================================================

set addModel 1
if { [info exists model] } {
    if { $model == "false" } {
	set addModel 0
    }
}
if { $addModel == 1 } {
   source pssd-register-doctypes.tcl
}

#=============================================================================
# Register role-members
#=============================================================================
#source pssd-register-rolemembers.tcl

#=============================================================================
# Set up roles & permissions
#=============================================================================
source pssd-roleperms.tcl


# ============================================================================
# Install triggers. 
# ============================================================================
#source triggers-install.tcl
