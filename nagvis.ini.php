; <?php return 1; ?>
; the line above is to prevent
; viewing this file from web.
; DON'T REMOVE IT!

[global]
file_group="www-data"
;authmodule="CoreAuthModIcingaweb2"
;authorisationmodule="CoreAuthorisationModIcingaweb2"
;logonmodule="LogonIcingaweb2"

[paths]
htmlcgi="/icingaweb2"

[defaults]
backend="live_1"
urltarget="_top"
hosturl="[htmlcgi]/monitoring/host/show?host=[host_name]"
hostgroupurl="[htmlcgi]/monitoring/list/hostgroups?hostgroup_name=[hostgroup_name]"
serviceurl="[htmlcgi]/monitoring/service/show?host=[host_name]&service=[service_description]"
servicegroupurl="[htmlcgi]/monitoring/list/servicegroups?servicegroup=[servicegroup_name]"
mapurl="[htmlcgi]/nagvis/show/map?map=[map_name]"
;headermenu=0
stylesheet="icingaweb-nagvis-integration.css"

[index]

[automap]

[wui]

[worker]

[backend_live_1]
backendtype="mklivestatus"
;socket="tcp:icinga:6558"
socket="unix:/run/icinga2/cmd/livestatus"

[backend_ndomy_1]
backendtype="ndomy"


[rotation_demo]
maps="demo-germany,demo-ham-racks,demo-load,demo-muc-srv1,demo-geomap,demo-automap"
interval=15

[states]

