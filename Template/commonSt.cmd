#!./bin/linux-x86_64/Template

#this is the common st.cmd file for templated IOCs

## Register all support components
dbLoadDatabase "/epics/iocs/Template/dbd/Template.dbd"
Template_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "/epics/iocs/Template/db/user.substitutions"
dbLoadRecords "/epics/iocs/Template/db/TemplateVersion.db", "user=rrainer"
dbLoadRecords "/epics/iocs/Template/db/dbSubExample.db", "user=rrainer"

