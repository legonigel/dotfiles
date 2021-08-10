#!/usr/bin/env bash

if [ -f ~/headset-charge-indicator/headset-charge-indicator.py ]; then
  python ~/headset-charge-indicator/headset-charge-indicator.py --headsetcontrol-binary /usr/local/bin/headsetcontrol
fi
