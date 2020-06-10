#!/bin/bash
tail -F .github/workflows/logfile&
tail -F ungoogled-chromium-83.0.4103.97-2-x86_64-prepare.log&
tail -F ungoogled-chromium-83.0.4103.97-2-x86_64-build.log&
tail -F ungoogled-chromium-83.0.4103.97-2-x86_64-package.log
