# $Id: matlab.m4 2652 2008-12-04 13:19:40Z keiner $
#
# Copyright (c) 2002, 2015 Jens Keiner, Stefan Kunis, Daniel Potts
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# @synopsis AX_LIB_FFTW3
# @summary Check configure options and assign variables related to the fftw3 library.
# @category C
#
# @version 2008-12-07
# @license GPLWithACException
# @author Jens Keiner <jens@nfft.org>
#
#  If we find the library, set the shell variable `ax_have_fftw3' to `yes'.
#  Otherwise, set `ax_have_fftw3' to `no'.

AC_DEFUN([AX_LIB_FFTW3],
[
  AC_ARG_WITH(fftw3, [AC_HELP_STRING([--with-fftw3=DIR],
  [compile with fftw3 in DIR])], with_fftw3=$withval, with_fftw3="yes")

  AC_ARG_WITH(fftw3-libdir, [AC_HELP_STRING([--with-fftw3-libdir=DIR],
  [compile with fftw3 library directory DIR])], fftw3_lib_dir=$withval, 
    fftw3_lib_dir="yes")

  AC_ARG_WITH(fftw3-includedir, [AC_HELP_STRING([--with-fftw3-includedir=DIR],
  [compile with fftw3 include directory DIR])], fftw3_include_dir=$withval, 
    fftw3_include_dir="yes")

  if test "x$with_fftw3" != "xyes"; then
    if test "x${fftw3_include_dir}" = "xyes"; then
      fftw3_include_dir="$with_fftw3/include"
    fi
    if test "x${fftw3_lib_dir}" = "xyes"; then 
      fftw3_lib_dir="$with_fftw3/lib"
    fi
  fi

  if test "x${fftw3_include_dir}" != "xyes"; then
    AX_CHECK_DIR([${fftw3_include_dir}],[],
      [AC_MSG_ERROR([The directory ${fftw3_include_dir} does not exist.])])
    fftw3_CPPFLAGS="-I$fftw3_include_dir"
  else
    fftw3_CPPFLAGS=""
  fi

  if test "x${fftw3_lib_dir}" != "xyes"; then 
    AX_CHECK_DIR([${fftw3_lib_dir}],[],
      [AC_MSG_ERROR([The directory ${fftw3_lib_dir} does not exist.])])
    fftw3_LDFLAGS="-L$fftw3_lib_dir"
  else
    fftw3_LDFLAGS=""
  fi

  saved_LDFLAGS="$LDFLAGS"
  saved_CPPFLAGS="$CPPFLAGS"
  CPPFLAGS="$CPPFLAGS $fftw3_CPPFLAGS"
  LDFLAGS="$LDFLAGS $fftw3_LDFLAGS"

  # Check if header is present and usable.
  AC_CHECK_HEADER([fftw3.h], [ax_lib_fftw3=yes;ax_lib_fftw3_threads=yes], [ax_lib_fftw3=no;ax_lib_fftw3_threads=no])

  if test "x$ax_lib_fftw3" = "xyes"; then
    saved_LIBS="$LIBS"
    AC_SEARCH_LIBS([fftw${PREC_SUFFIX}_execute], [fftw3${PREC_SUFFIX}], [ax_lib_fftw3=yes], [ax_lib_fftw3=no], [-lm])
    fftw3_LIBS="-lfftw3${PREC_SUFFIX} -lm"
    LIBS="$saved_LIBS"
  fi

  if test "x$enable_threads" = "xyes" -a "x$ax_lib_fftw3" = "xyes" -a "x$ax_lib_fftw3_threads" = "xyes"; then
    saved_LIBS="$LIBS"
    AC_SEARCH_LIBS([fftw${PREC_SUFFIX}_init_threads], [fftw3${PREC_SUFFIX}_threads], [ax_lib_fftw3_threads=yes], [ax_lib_fftw3_threads=no], [-lfftw3${PREC_SUFFIX} -lpthread -lm])
    fftw3_threads_LIBS="-lfftw3${PREC_SUFFIX}_threads -lfftw3${PREC_SUFFIX} -lpthread -lm"
    LIBS="$saved_LIBS"
  fi

  # Restore saved flags.
  CPPFLAGS="$saved_CPPFLAGS"
  LDFLAGS="$saved_LDFLAGS"

  AC_SUBST(fftw3_LIBS)
  AC_SUBST(fftw3_threads_LIBS)
  AC_SUBST(fftw3_LDFLAGS)
])
