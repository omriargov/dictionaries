#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# Copyright 2000, 2010 Oracle and/or its affiliates.
#
# OpenOffice.org - a multi-platform office productivity suite
#
# This file is part of OpenOffice.org.
#
# OpenOffice.org is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License version 3
# only, as published by the Free Software Foundation.
#
# OpenOffice.org is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License version 3 for more details
# (a copy is included in the LICENSE file that accompanied this code).
#
# You should have received a copy of the GNU Lesser General Public License
# version 3 along with OpenOffice.org.  If not, see
# <http://www.openoffice.org/license.html>
# for a copy of the LGPLv3 License.
#
#*************************************************************************

PRJ=..

PRJNAME=dictionaries
TARGET=dict-en-us

# --- Settings -----------------------------------------------------

.INCLUDE: settings.mk
# it might be useful to have an extension wide include to set things
# like the EXTNAME variable (used for configuration processing)
# .INCLUDE :  $(PRJ)$/source$/<extension name>$/<extension_name>.pmk

# --- Files --------------------------------------------------------

# name for uniq directory
EXTENSIONNAME:=dict-en
EXTENSION_ZIPNAME:=dict-en
COMPONENT_COPYONLY=TRUE

# some other targets to be done

# --- Extension packaging ------------------------------------------

# just copy:
COMPONENT_FILES= \
    $(EXTENSIONDIR)$/en_US.aff \
    $(EXTENSIONDIR)$/en_US.dic \
    $(EXTENSIONDIR)$/hyph_en_US.dic \
    $(EXTENSIONDIR)$/README.txt \
    $(EXTENSIONDIR)$/README_en_US.txt \
    $(EXTENSIONDIR)$/README_hyph_en_US.txt \
    $(EXTENSIONDIR)$/WordNet_license.txt

# disable fetching default OOo license text
# CUSTOM_LICENSE=WordNet_license.txt
# override default license destination
# PACKLICS= $(EXTENSIONDIR)$/registration$/$(CUSTOM_LICENSE)

COMPONENT_ZIP:=$(PWD)$/th_en_US_v2.zip
COMPONENT_UNZIP_FILES= \
    $(EXTENSIONDIR)$/th_en_US_v2.dat

# add own targets to packing dependencies (need to be done before
# packing the xtension
# EXTENSION_PACKDEPS=makefile.mk $(CUSTOM_LICENSE)
EXTENSION_PACKDEPS=$(COMPONENT_FILES) $(COMPONENT_UNZIP_FILES) $(EXTENSIONDIR)$/th_en_US_v2.idx

# global settings for extension packing
.INCLUDE : extension_pre.mk
.INCLUDE : target.mk
# global targets for extension packing
.INCLUDE : extension_post.mk

.IF "$(COMPONENT_UNZIP_FILES)"!=""
$(COMPONENT_UNZIP_FILES) .SILENT .UPDATEALL : "$(COMPONENT_ZIP)"
    cd $(EXTENSIONDIR) && unzip -o $< $(COMPONENT_UNZIP_FILES:f:t" ")
.ENDIF			# "$(COMPONENT_UNZIP_FILES)"!=""

$(EXTENSIONDIR)$/th_en_US_v2.idx : "$(EXTENSIONDIR)$/th_en_US_v2.dat"
    @@-$(MKDIRHIER) $(@:d)
    $(PERL) $(SOLARBINDIR)$/th_gen_idx.pl -o $(EXTENSIONDIR)$/th_en_US_v2.idx <$(EXTENSIONDIR)$/th_en_US_v2.dat
