# -*- makefile -*-
# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Common files build
#

common-y=main.o util.o console_output.o uart_buffering.o
common-y+=memory_commands.o shared_mem.o system_common.o hooks.o
common-y+=gpio_common.o version.o printf.o queue.o
common-y+=throttle_ap.o

common-$(BOARD_daisy)+=extpower_snow.o
common-$(BOARD_snow)+=extpower_snow.o

common-$(CONFIG_BACKLIGHT_LID)+=backlight_lid.o
common-$(CONFIG_BATTERY_BQ20Z453)+=battery_bq20z453.o
common-$(CONFIG_BATTERY_BQ27541)+=battery.o battery_bq27541.o
common-$(CONFIG_BATTERY_LINK)+=battery_link.o
common-$(CONFIG_BATTERY_SMART)+=battery.o smart_battery.o
common-$(CONFIG_CHARGER)+=charge_state.o charger_common.o
common-$(CONFIG_CHARGER_BQ24192)+=charger_bq24192.o
common-$(CONFIG_CHARGER_BQ24715)+=charger_bq24715.o
common-$(CONFIG_CHARGER_BQ24725)+=charger_bq24725.o
common-$(CONFIG_CHARGER_BQ24707A)+=charger_bq24707a.o
common-$(CONFIG_CHARGER_BQ24738)+=charger_bq24738.o
common-$(CONFIG_CHARGER_TPS65090)+=pmu_tps65090_charger.o
common-$(CONFIG_CHIPSET_GAIA)+=chipset_gaia.o
common-$(CONFIG_CHIPSET_HASWELL)+=chipset_haswell.o
common-$(CONFIG_CHIPSET_IVYBRIDGE)+=chipset_ivybridge.o
common-$(CONFIG_CHIPSET_X86)+=chipset_x86_common.o
common-$(CONFIG_PMU_POWERINFO)+=pmu_tps65090_powerinfo.o
common-$(CONFIG_PMU_TPS65090)+=pmu_tps65090.o
common-$(CONFIG_EOPTION)+=eoption.o
common-$(CONFIG_EXTPOWER_FALCO)+=extpower_falco.o
common-$(CONFIG_EXTPOWER_GPIO)+=extpower_gpio.o
common-$(CONFIG_EXTPOWER_KIRBY)+=extpower_kirby.o
common-$(CONFIG_EXTPOWER_SPRING)+=extpower_spring.o
common-$(CONFIG_FLASH)+=flash_common.o
common-$(CONFIG_FMAP)+=fmap.o
common-$(CONFIG_I2C)+=i2c_common.o
common-$(CONFIG_I2C_ARBITRATION)+=i2c_arbitration.o
common-$(CONFIG_KEYBOARD_PROTOCOL_8042)+=keyboard_8042.o
common-$(CONFIG_KEYBOARD_PROTOCOL_MKBP)+=keyboard_mkbp.o
common-$(CONFIG_KEYBOARD_TEST)+=keyboard_test.o
common-$(CONFIG_LED_COMMON)+=led_common.o
common-$(CONFIG_LED_DRIVER_DS2413)+=led_driver_ds2413.o
common-$(CONFIG_LED_DRIVER_LP5562)+=led_driver_lp5562.o
common-$(CONFIG_LID_SWITCH)+=lid_switch.o
common-$(CONFIG_LPC)+=port80.o
common-$(CONFIG_ONEWIRE)+=onewire.o
common-$(CONFIG_POWER_BUTTON)+=power_button.o
common-$(CONFIG_POWER_BUTTON_X86)+=power_button_x86.o
common-$(CONFIG_PSTORE)+=pstore_commands.o
common-$(CONFIG_FAN)+=pwm_fan.o
common-$(CONFIG_REGULATOR_IR357X)+=regulator_ir357x.o
common-$(CONFIG_SWITCH)+=switch.o
common-$(CONFIG_WIRELESS)+=wireless.o
common-$(CONFIG_TEMP_SENSOR)+=temp_sensor.o thermal.o
common-$(CONFIG_TEMP_SENSOR_G781)+=temp_sensor_g781.o
common-$(CONFIG_TEMP_SENSOR_TMP006)+=temp_sensor_tmp006.o
common-$(CONFIG_USB_PORT_POWER_SMART)+=usb_port_power_smart.o
common-$(CONFIG_USB_PORT_POWER_DUMB)+=usb_port_power_dumb.o
common-$(CONFIG_USB_SWITCH_TSU6721)+=usb_switch_tsu6721.o
common-$(HAS_TASK_CHIPSET)+=chipset.o
common-$(HAS_TASK_CONSOLE)+=console.o
common-$(HAS_TASK_HOSTCMD)+=host_command.o host_event_commands.o
common-$(HAS_TASK_KEYSCAN)+=keyboard_scan.o
common-$(HAS_TASK_LIGHTBAR)+=lightbar.o
common-$(HAS_TASK_VBOOTHASH)+=sha256.o vboot_hash.o
common-$(TEST_BUILD)+=test_util.o
