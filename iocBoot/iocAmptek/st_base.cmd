< envPaths
epicsEnvSet(STARTUP,$(TOP)/iocBoot/$(IOC))

dbLoadDatabase("../../dbd/mcaAmptekApp.dbd",0,0)
mcaAmptekApp_registerRecordDeviceDriver(pdbbase) 

drvAmptekConfigure(Amptek1, 0, "164.54.160.200")

#asynSetTraceMask(Amptek1, 0, 9)
asynSetTraceIOMask(Amptek1, 0, 2)

dbLoadRecords("$(TOP)/db/mca.db","P=mcaTest:,M=mca1,NCHAN=8192,DTYP=asynMCA,INP=@asyn(Amptek1)")
dbLoadRecords("$(TOP)/db/Amptek.db","P=mcaTest:,R=Amptek1:,PORT=Amptek1")

dbLoadRecords("$(ASYN)/db/asynRecord.db","P=mcaTest:,R=asyn1,PORT=Amptek1,ADDR=0,OMAX=256,IMAX=256")

< save_restore.cmd

iocInit()

# save settings every thirty seconds
create_monitor_set("auto_settings.req",30,"P=mcaTest:,M=mca1,R=Amptek1:")

asynReport 10 Amptek1