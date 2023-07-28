TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += TemplateSupport

# Compile and add code to the support library
TemplateSupport_SRCS += xxxRecord.c
TemplateSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
TemplateSupport_SRCS += dbSubExample.c
TemplateSupport_SRCS += devTemplateVersion.c
TemplateSupport_SRCS += TemplateHello.c
TemplateSupport_SRCS += initTrace.c

TemplateSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = TemplateVersion.h
# Macro name
GENVERSIONMACRO = TemplateVERSION

# Build the IOC application
PROD_IOC = Template

# Template.dbd will be created and installed
DBD += Template.dbd

# Template.dbd will include these files:
Template_DBD += base.dbd
Template_DBD += xxxSupport.dbd
Template_DBD += dbSubExample.dbd
Template_DBD += devTemplateVersion.dbd
Template_DBD += TemplateHello.dbd
Template_DBD += initTrace.dbd

# Template_registerRecordDeviceDriver.cpp derives from Template.dbd
Template_SRCS += Template_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
Template_SRCS_DEFAULT += TemplateMain.cpp
Template_SRCS_vxWorks += -nil-

# Link in the code from our support library
Template_LIBS += TemplateSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into TemplateSupport
    sncExample_SNCFLAGS += +r
    Template_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    TemplateSupport_SRCS += sncExample.stt
    TemplateSupport_LIBS += seq pv
    Template_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    Template_LIBS += qsrv
    Template_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    Template_DBD += PVAServerRegister.dbd
    Template_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
Template_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devTemplateVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
