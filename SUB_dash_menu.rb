require 'rainbow'
require 'net/ssh'
require_relative 'lib/terminal-basic-menu'
require_relative 'info_get'
require_relative 'connection_test'
require_relative 'SUB_dash_menu'
require_relative 'SUB_array_menu'
require_relative 'SUB_array_start_menu'
require_relative 'SUB_array_stop_menu'
require_relative 'SUB_main_menu'
require_relative 'SUB_setup_menu'
require_relative 'SUB_ssh_menu'
require_relative 'SUB_start_menu'
require_relative 'SUB_tools_menu'
require_relative 'main'

def dashboard_menu(keys_entered)
    if keys_entered == '1'
        run_ssh_cmd("df")
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd("cat /etc/samba/smb-shares.conf")
        return_after_connection = 'WAITING...'
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd("docker ps")
        return_on_enter
    elsif keys_entered == '4'
        puts ">> System Information <<\n"
        run_ssh_cmd("uname -a")
        puts "\n>> UnRaid Version <<\n"
        run_ssh_cmd("cat /etc/unraid-version")
        puts "\n>> Public IP Address <<\n"
        run_ssh_cmd("net lookup google.com")
        puts "\n>> CPU Status <<\n"
        run_ssh_cmd("sensors")
        puts "\n>> Memory Status <<\n"
        run_ssh_cmd("free -t")
        puts "\n>> Current Users <<\n"
        run_ssh_cmd("w")
        return_on_enter
    elsif keys_entered == '5'
        menu_navigator('main')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        menu_navigator($current_menu)
    end    
end