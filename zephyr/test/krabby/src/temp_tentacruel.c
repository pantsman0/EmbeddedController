/* Copyright 2022 The ChromiumOS Authors
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include <zephyr/kernel.h>
#include <zephyr/ztest.h>
#include <zephyr/drivers/adc.h>
#include <zephyr/drivers/adc/adc_emul.h>

#include "charger.h"
#include "charge_state.h"
#include "charger_profile_override.h"
#include "common.h"
#include "config.h"
#include "hooks.h"
#include "util.h"
#include "temp_sensor.h"
#include "temp_sensor/temp_sensor.h"

#define ADC_DEVICE_NODE DT_NODELABEL(adc0)
#define CHARGER_TEMP TEMP_SENSOR_ID(DT_NODELABEL(temp_charger))
#define ORIGINAL_CURRENT 5000
#define TEMP_THRESHOLD 55

struct charge_state_data curr;
static int fake_voltage;
int count;

/* Limit charging current table : 3600/3000/2400/1800
 * note this should be in descending order.
 */
static uint16_t current_table[] = {
	3600,
	3000,
	2400,
	1800,
};

int setup_faketemp(int fake_voltage)
{
	const struct device *adc_dev = DEVICE_DT_GET(ADC_DEVICE_NODE);
	int emul_temp;

	emul_temp = adc_emul_const_value_set(
		adc_dev, temp_sensors[CHARGER_TEMP].idx, fake_voltage);
	return emul_temp;
}

static void ignore_first_minute(void)
{
	for (int i = 0; i < 60; i++) {
		hook_notify(HOOK_SECOND);
	}
}

ZTEST(temp_tentacruel, test_decrease_current)
{
	fake_voltage = 376;
	curr.batt.flags |= BATT_FLAG_RESPONSIVE;
	count = 0;

	setup_faketemp(fake_voltage);
	/* Calculate per minute temperature.
	 * It's expected low temperature when the first 60 seconds.
	 */
	ignore_first_minute();
	for (int i = 1; i < 26; i++) {
		hook_notify(HOOK_SECOND);
		curr.requested_current = ORIGINAL_CURRENT;
		charger_profile_override(&curr);
		if (i % 6 == 0) {
			zassert_equal(current_table[count],
				      curr.requested_current, NULL);
			count++;
		}
	}
	zassert_equal(count, 4, NULL);
}

ZTEST(temp_tentacruel, test_increase_current)
{
	fake_voltage = 380;
	curr.batt.flags |= BATT_FLAG_RESPONSIVE;
	count = 3;

	setup_faketemp(fake_voltage);
	for (int i = 1; i < 26; i++) {
		hook_notify(HOOK_SECOND);
		curr.requested_current = ORIGINAL_CURRENT;
		charger_profile_override(&curr);
		if (i % 5 == 0) {
			if (curr.requested_current == ORIGINAL_CURRENT) {
				zassert_equal(ORIGINAL_CURRENT,
					      curr.requested_current, NULL);
			} else {
				zassert_equal(current_table[count],
					      curr.requested_current, NULL);
				count--;
			}
		}
	}
	zassert_equal(count, -1, NULL);
}

ZTEST_SUITE(temp_tentacruel, NULL, NULL, NULL, NULL, NULL);