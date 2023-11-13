#!/bin/sh
# verify that od -t x8 works properly
# This would fail before coreutils-4.5.2.

# Copyright (C) 2002-2022 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

. "${srcdir=.}/tests/init.sh"; path_prepend_ ./src
print_ver_ od

od -t x8 /dev/null >/dev/null ||
  skip_ "od lacks support for 8-byte quantities"

echo abcdefgh |tr -d '\n' > in || framework_failure_


od -An -t x8 in > out-raw || fail=1
sed 's/^ //;s/\(..\)/\1 /g;s/ $//' out-raw \
  | tr ' ' '\n' \
  | sort -n \
  > out

od -An -t x1 in \
  | sed 's/^ //' \
  | tr ' ' '\n' \
  | sort -n \
  > exp

compare exp out || fail=1

Exit $fail
