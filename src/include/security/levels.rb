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

# File:	include/security/levels.ycp
# Module:	Security configuration
# Summary:	Security settings definitions
# Authors:	Michal Svec <msvec@suse.cz>
#
# $Id$
#
# This file contains definitions of all security settings.
# They are in one huge list.
#
# <pre>
# $[
#   "name" : &lt;string Level>
#   "settings" : $[
#     &lt;string ID> : &lt;string Value>,
#     ...
#   ]
# ]
# </pre>

# @return [Array] all security settings
module Yast
  module SecurityLevelsInclude
    def initialize_security_levels(include_target)
      textdomain "security"

      # Level names definitions
      @LevelsNames = {
        # level name
        "Level1" => _("Home Workstation"),
        # level name
        "Level2" => _("Networked Workstation"),
        # level name
        "Level3" => _("Network Server")
      }

      @LevelsLabels = {
        # RadioButton label
        "Level1" => _("&Home Workstation"),
        # RadioButton label
        "Level2" => _("N&etworked Workstation"),
        # RadioButton label
        "Level3" => _("Network &Server")
      }

      # Levels definitions
      @Levels =
        # end of Levels
        {
          "Level1" => {
            "CONSOLE_SHUTDOWN"                          => "reboot",
            "CRACKLIB_DICT_PATH"                        => "/usr/lib/cracklib_dict",
            "DISPLAYMANAGER_REMOTE_ACCESS"              => "no",
            "kernel.sysrq"                              => "1",
            "FAIL_DELAY"                                => "1",
            "GID_MAX"                                   => "60000",
            "GID_MIN"                                   => "1000",
            "DISPLAYMANAGER_SHUTDOWN"                   => "all",
            "HIBERNATE_SYSTEM"                          => "active_console",
            "PASSWD_ENCRYPTION"                         => "sha512",
            "PASSWD_USE_CRACKLIB"                       => "yes",
            "PASS_MAX_DAYS"                             => "99999",
            "PASS_MIN_DAYS"                             => "0",
            "PASS_MIN_LEN"                              => "5",
            "PASS_WARN_AGE"                             => "7",
            "PERMISSION_SECURITY"                       => "easy",
            "RUN_UPDATEDB_AS"                           => "nobody",
            "UID_MAX"                                   => "60000",
            "UID_MIN"                                   => "1000",
            "SYS_UID_MAX"                               => "499",
            "SYS_UID_MIN"                               => "100",
            "SYS_GID_MAX"                               => "499",
            "SYS_GID_MIN"                               => "100",
            "USERADD_CMD"                               => "/usr/sbin/useradd.local",
            "USERDEL_PRECMD"                            => "/usr/sbin/userdel-pre.local",
            "USERDEL_POSTCMD"                           => "/usr/sbin/userdel-post.local",
            "PASSWD_REMEMBER_HISTORY"                   => "0",
            "SYSTOHC"                                   => "yes",
            "SYSLOG_ON_NO_ERROR"                        => "yes",
            "DISPLAYMANAGER_ROOT_LOGIN_REMOTE"          => "no",
            "DISPLAYMANAGER_XSERVER_TCP_PORT_6000_OPEN" => "no",
            "SMTPD_LISTEN_REMOTE"                       => "no",
            "DISABLE_STOP_ON_REMOVAL"                   => "no",
            "DISABLE_RESTART_ON_UPDATE"                 => "no",
            "net.ipv4.tcp_syncookies"                   => "1",
            "net.ipv4.ip_forward"                       => "0",
            "net.ipv6.conf.all.forwarding"              => "0"
          },
          "Level2" => {
            "CONSOLE_SHUTDOWN"                          => "ignore",
            "CRACKLIB_DICT_PATH"                        => "/usr/lib/cracklib_dict",
            "DISPLAYMANAGER_REMOTE_ACCESS"              => "no",
            "kernel.sysrq"                              => "0",
            "FAIL_DELAY"                                => "6",
            "GID_MAX"                                   => "60000",
            "GID_MIN"                                   => "1000",
            "DISPLAYMANAGER_SHUTDOWN"                   => "root",
            "HIBERNATE_SYSTEM"                          => "active_console",
            "PASSWD_ENCRYPTION"                         => "sha512",
            "PASSWD_USE_CRACKLIB"                       => "yes",
            "PASS_MAX_DAYS"                             => "99999",
            "PASS_MIN_DAYS"                             => "1",
            "PASS_MIN_LEN"                              => "5",
            "PASS_WARN_AGE"                             => "14",
            "PERMISSION_SECURITY"                       => "easy",
            "RUN_UPDATEDB_AS"                           => "nobody",
            "UID_MAX"                                   => "60000",
            "UID_MIN"                                   => "1000",
            "SYS_UID_MAX"                               => "499",
            "SYS_UID_MIN"                               => "100",
            "SYS_GID_MAX"                               => "499",
            "SYS_GID_MIN"                               => "100",
            "USERADD_CMD"                               => "/usr/sbin/useradd.local",
            "USERDEL_PRECMD"                            => "/usr/sbin/userdel-pre.local",
            "USERDEL_POSTCMD"                           => "/usr/sbin/userdel-post.local",
            "PASSWD_REMEMBER_HISTORY"                   => "0",
            "SYSTOHC"                                   => "yes",
            "SYSLOG_ON_NO_ERROR"                        => "yes",
            "DISPLAYMANAGER_ROOT_LOGIN_REMOTE"          => "no",
            "DISPLAYMANAGER_XSERVER_TCP_PORT_6000_OPEN" => "no",
            "SMTPD_LISTEN_REMOTE"                       => "no",
            "DISABLE_STOP_ON_REMOVAL"                   => "no",
            "DISABLE_RESTART_ON_UPDATE"                 => "no",
            "net.ipv4.tcp_syncookies"                   => "1",
            "net.ipv4.ip_forward"                       => "0",
            "net.ipv6.conf.all.forwarding"              => "0"
          },
          "Level3" => {
            "CONSOLE_SHUTDOWN"                          => "ignore",
            "CRACKLIB_DICT_PATH"                        => "/usr/lib/cracklib_dict",
            "DISPLAYMANAGER_REMOTE_ACCESS"              => "no",
            "kernel.sysrq"                              => "0",
            "FAIL_DELAY"                                => "3",
            "GID_MAX"                                   => "60000",
            "GID_MIN"                                   => "1000",
            "DISPLAYMANAGER_SHUTDOWN"                   => "root",
            "HIBERNATE_SYSTEM"                          => "active_console",
            "PASSWD_ENCRYPTION"                         => "sha512",
            "PASSWD_USE_CRACKLIB"                       => "yes",
            "PASS_MAX_DAYS"                             => "99999",
            "PASS_MIN_DAYS"                             => "1",
            "PASS_MIN_LEN"                              => "6",
            "PASS_WARN_AGE"                             => "14",
            "PERMISSION_SECURITY"                       => "secure",
            "RUN_UPDATEDB_AS"                           => "nobody",
            "UID_MAX"                                   => "60000",
            "UID_MIN"                                   => "1000",
            "SYS_UID_MAX"                               => "499",
            "SYS_UID_MIN"                               => "100",
            "SYS_GID_MAX"                               => "499",
            "SYS_GID_MIN"                               => "100",
            "USERADD_CMD"                               => "/usr/sbin/useradd.local",
            "USERDEL_PRECMD"                            => "/usr/sbin/userdel-pre.local",
            "USERDEL_POSTCMD"                           => "/usr/sbin/userdel-post.local",
            "PASSWD_REMEMBER_HISTORY"                   => "0",
            "SYSTOHC"                                   => "yes",
            "SYSLOG_ON_NO_ERROR"                        => "yes",
            "DISPLAYMANAGER_ROOT_LOGIN_REMOTE"          => "no",
            "DISPLAYMANAGER_XSERVER_TCP_PORT_6000_OPEN" => "no",
            "SMTPD_LISTEN_REMOTE"                       => "no",
            "DISABLE_STOP_ON_REMOVAL"                   => "no",
            "DISABLE_RESTART_ON_UPDATE"                 => "no",
            "net.ipv4.tcp_syncookies"                   => "1",
            "net.ipv4.ip_forward"                       => "0",
            "net.ipv6.conf.all.forwarding"              => "0"
          }
        } 

      # EOF
    end
  end
end
