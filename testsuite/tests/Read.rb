# encoding: utf-8

# YaST2: Modules testsuite
#
# Description:
#   Testsuite for the security module
#
# Authors:
#   Michal Svec <msvec@suse.cz>
#
# $Id$
#
# testedfiles: Security.ycp PamSettings.ycp Pam.ycp
module Yast
  class ReadClient < Client
    def main
      Yast.import "Testsuite"
      Yast.import "Security"

      @scr_info = {
        "sysconfig" => {
          "security"       => {
            "PERMISSION_SECURITY"       => "paranoid",
            "DISABLE_RESTART_ON_UPDATE" => "r13",
            "DISABLE_STOP_ON_REMOVAL"   => "r14"
          },
          "suseconfig"     => {
            "CWD_IN_ROOT_PATH" => "r2",
            "CWD_IN_USER_PATH" => "r3"
          },
          "displaymanager" => {
            "DISPLAYMANAGER_SHUTDOWN"                   => "r3",
            "DISPLAYMANAGER_REMOTE_ACCESS"              => "r9",
            "DISPLAYMANAGER_ROOT_LOGIN_REMOTE"          => "r16",
            "DISPLAYMANAGER_XSERVER_TCP_PORT_6000_OPEN" => "r17"
          },
          "locate"         => { "RUN_UPDATEDB_AS" => "r7" },
          "clock"          => { "SYSTOHC" => "r12" },
          "cron"           => { "SYSLOG_ON_NO_ERROR" => "r15" },
          "mail"           => { "SMTPD_LISTEN_REMOTE" => "r18" }
        },
        "etc"       => {
          "login_defs"                 => {
            "FAIL_DELAY"      => "l2",
            "GID_MAX"         => "l3",
            "GID_MIN"         => "l4",
            "PASS_MAX_DAYS"   => "l7",
            "PASS_MIN_DAYS"   => "l9",
            "PASS_MIN_LEN"    => "l10",
            "PASS_WARN_AGE"   => "l11",
            "UID_MAX"         => "l12",
            "UID_MIN"         => "l13",
            "SYSTEM_UID_MAX"  => "l14",
            "SYSTEM_UID_MIN"  => "l15",
            "SYSTEM_GID_MAX"  => "l16",
            "SYSTEM_GID_MIN"  => "l17",
            "USERADD_CMD"     => "l18",
            "USERDEL_PRECMD"  => "l19",
            "USERDEL_POSTCMD" => "l20",
            "ENCRYPT_METHOD"  => "garbage"
          },
          "inittab"                    => {
            "ca" => ":ctrlaltdel:/sbin/shutdown -r -t 4 now"
          },
          "sysctl_conf"                => {
            "kernel.sysrq"                 => "r8",
            "net.ipv4.tcp_syncookies"      => "r9",
            "net.ipv4.ip_forward"          => "r10",
            "net.ipv6.conf.all.forwarding" => "r11"
          },
          "polkit-default-privs_local" => {
            "org.freedesktop.upower.hibernate" => "r12"
          }
        },
        "target"    => {
          "size" => 1,
          # FileUtils::Exists (ctrl_alt_del_file) returns true, so symlink is called
          "stat" => {
            1 => 2
          }
        },
        "pam"       => {
          "passwd" => {
            "password" => {
              "pam_unix" => [
                { "arguments" => "nullok use_first_pass use_authtok" }
              ]
            }
          }
        }
      }

      @E = {
        "target" => {
          "bash_output" => {
            'exit'=>0,
            'stdout' => '',
            'stderr' => ''
          }
        }
      }

      Testsuite.Test(lambda { Security.Read }, [@scr_info, {}, @E], nil)
      # read garbage, changed to des
      Testsuite.Dump(Ops.get(Security.Settings, "PASSWD_ENCRYPTION"))

      Ops.set(@scr_info, ["etc", "login_defs", "ENCRYPT_METHOD"], "SHA512")
      # reads nil -> not in the Settings
      Ops.set(@scr_info, ["etc", "login_defs", "FAIL_DELAY"], nil)
      Testsuite.Test(lambda { Security.Read }, [@scr_info, {}, @E], nil)

      Testsuite.Dump(Ops.get(Security.Settings, "FAIL_DELAY", "none"))
      Testsuite.Dump(Ops.get(Security.Settings, "PASSWD_ENCRYPTION"))

      nil
    end
  end
end

Yast::ReadClient.new.main
