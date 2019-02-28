# af_alg.m4 serial 4
dnl Copyright 2018 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Matteo Croce.

AC_DEFUN_ONCE([gl_AF_ALG],
[
  AC_REQUIRE([gl_HEADER_SYS_SOCKET])
  AC_REQUIRE([AC_C_INLINE])

  dnl Check whether linux/if_alg.h has needed features.
  AC_CACHE_CHECK([whether linux/if_alg.h has struct sockaddr_alg.],
    [gl_cv_header_linux_if_alg_salg],
    [AC_COMPILE_IFELSE(
       [AC_LANG_PROGRAM([[#include <sys/socket.h>
                          #include <linux/if_alg.h>
                          struct sockaddr_alg salg = {
                            .salg_family = AF_ALG,
                            .salg_type = "hash",
                            .salg_name = "sha1",
                          };]])],
       [gl_cv_header_linux_if_alg_salg=yes],
       [gl_cv_header_linux_if_alg_salg=no])])
  if test "$gl_cv_header_linux_if_alg_salg" = yes; then
    AC_DEFINE([HAVE_LINUX_IF_ALG_H], [1],
      [Define to 1 if you have 'struct sockaddr_alg' defined.])
  fi

  dnl The default is to not use AF_ALG if available,
  dnl as it's system dependent as to whether the kernel
  dnl routines are faster than libcrypto for example.
  use_af_alg=no
  AC_ARG_WITH([linux-crypto],
    [AS_HELP_STRING([[--with-linux-crypto]],
       [use Linux kernel cryptographic API (if available)])],
    [use_af_alg=$withval],
    [use_af_alg=no])
  dnl We cannot use it if it is not available.
  if test "$gl_cv_header_linux_if_alg_salg" != yes; then
    if test "$use_af_alg" != no; then
      AC_MSG_WARN([Linux kernel cryptographic API not found])
    fi
    use_af_alg=no
  fi

  if test "$use_af_alg" != no; then
    USE_AF_ALG=1
  else
    USE_AF_ALG=0
  fi
  AC_DEFINE_UNQUOTED([USE_LINUX_CRYPTO_API], [$USE_AF_ALG],
    [Define to 1 if you want to use the Linux kernel cryptographic API.])
])
