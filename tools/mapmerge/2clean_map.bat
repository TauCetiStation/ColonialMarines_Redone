SET z_levels=7
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../_maps/cmr-z%%i.dmm.backup ../../_maps/cmr-z%%i.dmm ../../_maps/cmr-z%%i.dmm
)

pause