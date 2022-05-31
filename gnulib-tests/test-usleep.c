/* Test of usleep() function.
   Copyright (C) 2009-2020 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* Written by Eric Blake <ebb9@byu.net>, 2009.  */

#include <config.h>

#include <unistd.h>

#include "signature.h"
SIGNATURE_CHECK (usleep, int, (useconds_t));

#include <time.h>

#include "macros.h"

int
main (void)
{
  time_t start = time (NULL);
  ASSERT (usleep (1000000) == 0);
  ASSERT (start < time (NULL));

  ASSERT (usleep (0) == 0);

  return 0;
}
