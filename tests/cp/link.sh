#!/bin/sh
# Make sure cp --link -f works when the target exists.
# This failed for 4.0z (due to a bug introduced in that test release).

# Copyright (C) 2000-2018 Free Software Foundation, Inc.

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
print_ver_ cp

touch src || framework_failure_
touch dest || framework_failure_
touch dest2 || framework_failure_


cp -f --link src dest || fail=1
cp -f --symbolic-link src dest2 || fail=1

Exit $fail
