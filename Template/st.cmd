#!./bin/linux-x86_64/Template

## Register all support components
dbLoadDatabase "dbd/Template.dbd"
Template_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/TemplateVersion.db", "user=rrainer"
dbLoadRecords "db/dbSubExample.db", "user=rrainer"


iocInit
