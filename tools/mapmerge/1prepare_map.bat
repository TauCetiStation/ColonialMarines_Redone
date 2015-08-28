SET z_levels=7
cd ../../_maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy cmr-z%%i.dmm cmr-z%%i.dmm.backup
)

pause
