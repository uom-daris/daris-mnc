# remove the predeccessor (old release): mnc-pssd
if { [xvalue exists [package.exists :package mnc-pssd]] == "true" } {
    package.uninstall :package mnc-pssd
}
if { [xvalue exists [asset.exists :id path=/mflux/plugins/mnc-pssd-plugin.jar]] == "true" } {
    asset.hard.destroy :id path=/mflux/plugins/mnc-pssd-plugin.jar
}
if { [xvalue exists [asset.exists :id path=/mflux/plugins/libs/nig-commons.jar]] == "true" } {
    asset.hard.destroy :id path=/mflux/plugins/libs/nig-commons.jar
}
