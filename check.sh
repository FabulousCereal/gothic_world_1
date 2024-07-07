#!/bin/sh
exec find . -name '*.lua' -exec luacheck --globals love f0b res gamestate -- '{}' '+'
