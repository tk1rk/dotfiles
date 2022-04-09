#!/usr/bin/env sh
[ "$(amixer sget 'Master' | grep '\[off\]')" ] && echo "ﱙ" || echo "ﱘ"

