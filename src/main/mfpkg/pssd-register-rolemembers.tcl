#============================================================================#
# Register specific roles as available as 'role-members' when projects are   #
# created. Useful when changing teams all need access to lots of projects    #
# in e.g. a facility service capability
#
# Use
# om.pssd.role-member.regsitry.* to manipulate
#
#============================================================================#

set roleMembers { mnc-user }
foreach role $roleMembers {
    authorization.role.create :ifexists ignore :role $role
    om.pssd.role-member-registry.add :role $role
    
}