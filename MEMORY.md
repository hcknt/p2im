| Firmware | MCU | ROM(FLASH) Base | ROM Size(hex) | ROM Size(KB) | RAM(SRAM) Base | RAM Size(hex) | RAM Size(KB) | VTOR | Additional Writable Ranges |
|----------|-----|-----------------|---------------|--------------|----------------|---------------|--------------|------|----------------------------|
| Robot | STM32F103RB | 0x08000000 | 0x20000 | 128 | 0x20000000 | 0x5000 | 20 | 0x08000000 | 0x0,0x0 |
| Drone | STM32F103RB | 0x08000000 | 0x20000 | 128 | 0x20000000 | 0x5000 | 20 | 0x08000000 | 0x0,0x0 |
| Gateway | STM32F103RB | 0x08000000 | 0x20000 | 128 | 0x20000000 | 0x5000 | 20 | 0x08000000 | 0x0,0x0 |
| Reflow_Oven | STM32F103RB | 0x08000000 | 0x20000 | 128 | 0x20000000 | 0x5000 | 20 | 0x08000000 | 0x0,0x0 |
| Steering_Control | SAM3X8E | 0x00080000 | 0x40000 | 256 | 0x20070000 | 0x20000 | 128 | 0x80000 | 0x0,0x0 |
| Heat_Press | SAM3X8E | 0x00080000 | 0x40000 | 256 | 0x20070000 | 0x20000 | 128 | 0x80000 | 0x0,0x0 |
| Console | MK64FN1M0VLL12 | 0x00000000 | 0x40000 | 256 | 0x1ffe0000 | 0x40000 | 256 | 0x0 | - |
| CNC | STM32F429ZI | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x20000 | 128 | 0x08000000 | - |
| PLC | STM32F429ZI | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x30000 | 192 | 0x08000000 | 0x0,0x0 |
| GPS_Tracker | SAM3X/A | 0x00080000<br>0xa0000 | 0x10000<br>0x1000 | 64<br>4 | 0x20070000 | 0x18000 | 96 | 0x00080000 | 0x20180000<br>0x20000 |
| 3Dprinter | STM32F103RE | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x20000 | 128 | 0x08000000 | 0x0,0x0 |
| LiteOS_IoT | STM32L431 | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x40000 | 256 | 0x08000000 | 0x0,0x0 |
| Zepyhr_SocketCan | STM32L432KC | 0x08000000 | 0x20000 | 128 | 0x20000000 | 0x10000 | 64 | 0x8000000 | 0x0,0x0 |
| utasker_MODBUS | STM32F429ZIT6U | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x30000 | 192 | 0x0800c080 | 0x0,0x0 |
| utasker_USB | STM32F429ZIT6U | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x40000 | 256 | 0x0800c080 | 0x0,0x0 |
| Thermostat | MAX32600MBED | 0x00000000 | 0x10000 | 64 | 0x20000000 | 0x10000 | 64 | 0x00000000 | 0x0,0x0 |
| RF_Door_Lock | MAX32600MBED | 0x00000000 | 0x10000 | 64 | 0x20000000 | 0x10000 | 64 | 0x00000000 | 0x0,0x0 |
| XML_Parser | STM32L152XE | 0x08000000 | 0x40000 | 256 | 0x20000000 | 0x60000 | 384 | 0x08000000 | 0x0,0x0 |
| 6LoWPAN_Sender | SAMR21 | 0x00000000 | 0x40000 | 256 | 0x20000000 | 0x10000 | 64 | 0x00000000 | 0x0,0x0 |
| 6LoWPAN_Receiver | SAMR21 | 0x00000000 | 0x40000 | 256 | 0x20000000 | 0x10000 | 64 | 0x00000000 | 0x0,0x0 |

### Common ROM Base Addresses:

- `0x08000000`: STM32 standard Flash base (most common)
- `0x00000000`: Alternative Flash mapping
- `0x00080000`: Custom Flash offset

### Common RAM Base Addresses:

- `0x20000000`: Standard ARM Cortex-M SRAM base (most common)
- `0x20070000`: Custom SRAM offset (Heat Press, Steering Control, GPSTracker)
- `0x1ffe0000`: Freescale/NXP specific SRAM base (Console)

### Size Distributions:

- **ROM sizes**: 64 KB - 384 KB
- **RAM sizes**: 20 KB - 384 KB