#============================================================================#
# Register generic meta-data with specific PSSD objects                      #
# This is domain-specific, but not method-specific meta-data                 #
#============================================================================#
# Doc Type Namespace

# Basic project info
set mtypeArgs ":mtype -requirement mandatory mnc:project :mtype -requirement mandatory mnc:ethics"

# Notifications
set mtypeArgs "${mtypeArgs} :mtype -requirement mandatory daris:pssd-notification"

# Generic Project owner 
#set mtypeArgs "${mtypeArgs} :mtype -requirement mandatory daris:pssd-project-owner"

# ANDS harvesting
set mtypeArgs "${mtypeArgs} :mtype -requirement optional daris:pssd-project-harvest"

# Append to any pre-existing associations (e.g. set by pssd package)
set args ":append true :type project ${mtypeArgs}"
om.pssd.type.metadata.set $args