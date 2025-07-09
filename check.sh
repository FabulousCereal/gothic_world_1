#!/bin/sh
# SPDX-FileCopyrightText: 2024 Grupo Warominutes
# SPDX-License-Identifier: Apache-2.0
exec find . -name '*.lua' -exec luacheck --globals love f0b res gamestate -- '{}' '+'
