ccflags-y += -Idrivers/media/platform/msm/camera/cam_utils
ccflags-y += -Idrivers/media/platform/msm/camera/cam_cpas/include
ccflags-y += -Idrivers/media/platform/msm/camera/cam_sensor_module/cam_sensor_io
ccflags-y += -Idrivers/media/platform/msm/camera/cam_sensor_module/cam_sensor_utils
ccflags-y += -Idrivers/media/platform/msm/camera/cam_req_mgr
ccflags-y += -Idrivers/media/platform/msm/camera/cam_sensor_module/cam_cci
ccflags-y += -Idrivers/media/platform/msm/camera/cam_smmu/
obj-$(CONFIG_SPECTRA_CAMERA) += 3dsl_eeprom_dev.o 3dsl_eeprom_core.o 3dsl_eeprom_soc.o

# Ignore this warn
ifeq ($(cc-name),clang)
EXTRA_CFLAGS += $(call cc-disable-warning,enum-conversion,)
endif
