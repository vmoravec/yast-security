# encoding: utf-8

# ------------------------------------------------------------------------------
# Copyright (c) 2006-2012 Novell, Inc. All Rights Reserved.
#
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail, you may find
# current contact information at www.novell.com.
# ------------------------------------------------------------------------------

#  * File:	include/security/widgets.ycp
#  * Module:	Security configuration
#  * Summary:	Security widgets definitions
#  * Authors:	Michal Svec <msvec@suse.cz>
#  *
#  * $Id$
#  *
#  * This file contains the definitions of all widgets used by the
#  * security module. They are all in one map (function) called
#  * WIDGETS.
#
# <pre>
#
# The WIDGETS format:
# -------------------
#
# map WIDGETS = $[
#     "Item unique ID" : $[
# 	"Widget" : "ComboBox",
# 	"Label" : "Item Label",
# 	"Options" : [ "option1", "option2", ... ],
# 	"Value" : "option2"
#     ],
#   ...
# ];
#
# The "Value" is the current value of this option and one from "Options".
#
# Particular "Options" can be either <string> or [ <string>, <string> ]. In the
# latter case, the first string is used as ID and the second is displayed. For
# example: [ "option1", ["option2",_("Option2 translation")], ... ].
#
# Possible "Widget" values so far: "ComboBox, CheckBox, TextEntry".
#
# Implementation:
# ---------------
#
# map2widget("ID")
# - look up the "ID" in the "WIDGETS" map
# - create the widget
#
# widget2value("ID")
# - query UI for the widget with `id(ID)
# - return its current value
#
# updatewidget("ID")
# - look up the "ID" and change its "Value" to the "val"
# - updates the WIDGETS map
# - called after start and after each subdialog [OK]
# - must check if the value is in "Options"! (TODO)
#
# processinput()
# - return true (OK) or false (abort, back, nil, help!, ...)
#
# </pre>
#
#  *

# @return [Hash] all widgets
module Yast
  module SecurityWidgetsInclude
    def initialize_security_widgets(include_target)
      textdomain "security"

      # All widgets are here
      @WIDGETS =
        #     "" : $[
        # 	"Widget" : "",
        # 	/* Widget label * /
        # 	"Label" : _(""),
        # 	/* Widget values * /
        # 	"Options" : [["",_("")]],
        # 	"Value" : ""
        #     ],
        {
          "CONSOLE_SHUTDOWN"             => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _(
              "&Interpretation of Ctrl + Alt + Del"
            ),
            "Options" => [
              # ComboBox value
              ["ignore", _("Ignore")],
              # ComboBox value
              ["reboot", _("Reboot")],
              # ComboBox value
              ["halt", _("Halt")]
            ],
            "Value"   => "reboot"
          },
          "CWD_IN_ROOT_PATH"             => {
            "Widget" => "CheckBox",
            # CheckBox label
            "Label"  => _("&Current Directory in root's Path"),
            "Value"  => "yes"
          },
          "CWD_IN_USER_PATH"             => {
            "Widget" => "CheckBox",
            # CheckBox label
            "Label"  => _(
              "Curr&ent Directory in Path of Regular Users"
            ),
            "Value"  => "yes"
          },
          "DISPLAYMANAGER_REMOTE_ACCESS" => {
            "Widget" => "CheckBox",
            # CheckBox label
            "Label"  => _("Allow Remote &Graphical Login"),
            "Value"  => "no"
          },
          "kernel.sysrq"                 => {
            "Widget"   => "ComboBox",
            # CheckBox label
            "Label"    => _("&Magic SysRq Keys"),
            "Options"  => [
              # ComboBox value
              ["0", _("Disable")],
              # ComboBox value
              ["1", _("Enable All Functions")]
            ],
            "Editable" => "yes"
          },
          "FAIL_DELAY"                   => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _(
              "&Delay after Incorrect Login Attempt"
            ),
            "Value"  => "3"
          },
          "GID_MAX"                      => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("Maxim&um"),
            "Value"  => "60000"
          },
          "GID_MIN"                      => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("M&inimum"),
            "Value"  => "101"
          },
          "DISPLAYMANAGER_SHUTDOWN"      => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _(
              "&Shutdown Behaviour of KDM Login Manager:"
            ),
            "Options" => [
              # ComboBox value
              ["root", _("Only root")],
              # ComboBox value
              ["all", _("All Users")],
              # ComboBox value
              ["none", _("Nobody")],
              # ComboBox value
              #	    ["local",_("Local Users")],
              # ComboBox value
              ["auto", _("Automatic")]
            ],
            "Value"   => "all"
          },
          "HIBERNATE_SYSTEM"             => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _("System Hybernation"),
            "Options" => [
              # ComboBox value
              ["active_console", _("User on the active console")],
              # ComboBox value
              ["anyone", _("Anyone can hibernate")],
              # ComboBox value
              ["auth_admin", _("Authentication always required")]
            ],
            "Value"   => "active_console"
          },
          "PASSWD_ENCRYPTION"            => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _("P&assword Encryption Method"),
            # ComboBox values
            "Options" => [
              ["des", "DES"],
              ["md5", "MD5"],
              ["sha256", "SHA-256"],
              ["sha512", "SHA-512"]
            ],
            "Value"   => "des",
            "Notify"  => "yes"
          },
          "PASSWD_USE_CRACKLIB"          => {
            "Widget" => "CheckBox",
            # CheckBox label
            "Label"  => _("&Check New Passwords"),
            "Notify" => "yes",
            "Value"  => "yes"
          },
          "PASS_MAX_DAYS"                => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("Maxim&um"),
            "Value"  => "99999"
          },
          "PASSWD_REMEMBER_HISTORY"      => {
            "Widget"   => "IntField",
            # IntField label
            "Label"    => _("Numb&er of Passwords to Remember"),
            "MinValue" => 0,
            "MaxValue" => 400
          },
          "PASS_MIN_DAYS"                => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("M&inimum"),
            "Value"  => "0"
          },
          "PASS_MIN_LEN"                 => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _(
              "&Minimum Acceptable Password Length"
            ),
            "Value"  => "5"
          },
          "PASS_WARN_AGE"                => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _(
              "&Days before Password Expires Warning"
            ),
            "Value"  => "7"
          },
          "PERMISSION_SECURITY"          => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _("&File Permissions"),
            "Options" => [
              # ComboBox value
              ["easy", _("Easy")],
              # ComboBox value
              ["secure", _("Secure")],
              # ComboBox value
              ["paranoid", _("Paranoid")]
            ],
            "Value"   => "secure"
          },
          "RUN_UPDATEDB_AS"              => {
            "Widget"  => "ComboBox",
            # ComboBox label
            "Label"   => _("&User Launching updatedb"),
            "Options" => ["nobody", "root"],
            "Value"   => "nobody"
          },
          "UID_MAX"                      => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("Ma&ximum"),
            "Value"  => "60000"
          },
          "UID_MIN"                      => {
            "Widget" => "IntField",
            # IntField label
            "Label"  => _("&Minimum"),
            "Value"  => "100"
          }
        } 

      # EOF
    end
  end
end
