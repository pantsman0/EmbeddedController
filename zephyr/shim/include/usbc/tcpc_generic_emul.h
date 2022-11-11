/* Copyright 2022 The ChromiumOS Authors
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include "driver/tcpm/tcpci.h"

#include <zephyr/devicetree.h>

#define TCPCI_EMUL_COMPAT cros_tcpci_generic_emul

#define TCPC_CONFIG_TCPCI_EMUL(id) \
	{                                                                      \
		.bus_type = EC_BUS_TYPE_I2C,                                   \
		.i2c_info = {                                                  \
			.port = I2C_PORT_BY_DEV(id),                           \
			.addr_flags = DT_REG_ADDR(id),                         \
		},                                                             \
		.drv = &tcpci_tcpm_drv,                                        \
		.alert_signal = COND_CODE_1(DT_NODE_HAS_PROP(id, alert_gpio),  \
			(GPIO_SIGNAL(DT_PHANDLE(id, alert_gpio))),             \
			(GPIO_LIMIT)),                                         \
	},
