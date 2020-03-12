# frozen_string_literal: true

# body_text = "Please enter a selection from the following:"
# body_choices = ['Setup Wizard', 'SSH Dashboard', 'SSH ToolBox', 'Array Tools','Exit']
# footer_text = "Your current location is: /Main Menu/"
# $current_menu = 'main'
# $menu_full_name = 'Home Menu'

# elsif option == "cpu_menu"
#     body_text = "What would you like to run?"
#     body_choices = ['Short summary of CPU info', 'Much longer report of all CPUs', 'Check for 64bit mode support and CPU virtualization support', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Tools Menu"
#     $current_menu = 'cpu_menu'
#     $menu_full_name = 'CPU Tools Menu'
# elsif option == "network_menu"
#     body_text = "What would you like to see information on?"
#     body_choices = ['Lists the installed kernel modules, including your network driver', 'Display the network driver being used by your network chipset and its version', 'Displays settings for network chipset eg speed setting, gigabit connection, Wake-on-LAN', 'Parameters and statistics eg MAC address, transmit/receive statistics, including errors and collisions','Display more detailed network statistics', 'Check for correct nameserver and DNS configuration', 'Another way to check for correct nameserver configuration', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/Network Tools Menu"
#     $current_menu = 'network_menu'
#     $menu_full_name = 'Network Tools Menu'
# elsif option == "hdd_menu"
#     body_text = "What would you like to see information on?"
#     body_choices = ['View the identity and configuration information for a drive', 'Determine the read speed of a hard drive', 'STMART info for a drive: identity,configuration info, physical statistics and error history', 'Some newer drives and disk controllers will not issue a report if you use the -d ata option','Short SMART test on a drive (short test takes minutes)', 'Long SMART test on a drive, (long test can take several hours)', 'To view the partitioning of a drive,geometry and sectors', 'To obtain the total number of sectors on a drive', 'To verify how the drive is labeled', 'Drives by model, serial number drive device ID (sda, hdc, etc) linked to each', 'Drives by model, serial number deviceID and links', 'Drive devices with volume labels and device ID: Typically, only the flash drive', 'Reports file system disk space usage', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/Hard Drive Tools Menu"
#     $current_menu = 'hdd_menu'
#     $menu_full_name = 'Hard Drive Tools Menu'
# elsif option == "admin_menu"
#     body_text = "What would you like to see information on?"
#     body_choices = ['Display current end of syslog', 'Show current memory usage', 'List processes similar to top', 'List the processes on the server and their memory size sorted', 'Show system configuration parameters, including security and permissions','Show who is logged on and what they are doing', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/Admin Tools Menu"
#     $current_menu = 'admin_menu'
#     $menu_full_name = 'Admin Tools Menu'
# elsif option == "misc_menu"
#     body_text = "What would you like to see information on?"
#     body_choices = ['Displays information about PCI buses and devices', 'Displays more verbose information about PCI buses and devices', 'Displays even more information about PCI buses and devices including device numbers and assigned kernel modules', 'Displays information about SCSI devices','Displays more verbose information about SCSI devices, including ATA numbers', 'Displays information about USB buses and the devices connected to them', 'Displays the raw information from DMI/SMBIOS tables', 'Displays available sensor info (CPU, drive temperatures, system voltages, fan speeds)', 'Analyses system and displays all available sensors and needed modules, requires Perl installed first', 'Displays the Linux kernel version', 'Displays the version of the network driver being used by your network chipset (for eth0)', 'Displays the version of OpenSSL', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Misc Menu"
#     $current_menu = 'misc_menu'
#     $menu_full_name = 'Misc Tools Menu'
# elsif option == "mem_menu"
#     body_text = "What would you like to see information on?"
#     body_choices = ['Abbreviated summary of general memory info', 'Summary of general memory info with totals', 'Summary of general memory info with totals, all in megabytes', 'A more complete report of memory usage','Displays virtual memory statistics', 'Detailed virtual memory usage', 'Return to SSH ToolBox Menu','Exit']
#     footer_text = "Your current location is: /Main Menu/SSH ToolBox/Memory Tools Menu"
#     $current_menu = 'mem_menu'
#     $menu_full_name = 'Memory Tools Menu'
                                        1                                   2                                             3                                 4                                                5                                                 6                                   7                                         8                              9                          10                                                 11                             12      13                                       

def hdd_menu(keys_entered)
hdd_info = ["hdparm  -I  /dev/#{$hdd_choice}", "hdparm  -tT  /dev/#{$hdd_choice}", "smartctl  -a  -d  ata  /dev/#{$hdd_choice}", "smartctl -a /dev/#{$hdd_choice}", "smartctl  -d  ata  -tshort  /dev/#{$hdd_choice}", "smartctl  -d  ata  -tlong  /dev/#{$hdd_choice}", "fdisk  -l  -u  /dev/#{$hdd_choice}", "blockdev  --getsz  /dev/#{$hdd_choice}", "vol_id  /dev/#{$hdd_choice}1", "ls  -l  /dev/disk/by-id", "ls  -l  /dev/disk/by-id/[au]*  |  grep  -v  part1 ", "ls  -l  /dev/disk/by-label", "df"]
    menu_length = hdd_info.length + 2
    if keys_entered == '1'
        get_desired_drive(hdd_info[0])
    elsif keys_entered == '2'
        get_desired_drive(hdd_info[1])
    elsif keys_entered == '3'
        get_desired_drive(hdd_info[2])
    elsif keys_entered == '4'
        get_desired_drive(hdd_info[3])
    elsif keys_entered == '5'
        rget_desired_drive(hdd_info[4])
    elsif keys_entered == '6'
        get_desired_drive(hdd_info[5])
    elsif keys_entered == '7'
        get_desired_drive(hdd_info[6])
    elsif keys_entered == '8'
        rget_desired_drive(hdd_info[7])
    elsif keys_entered == '9'
        get_desired_drive(hdd_info[8])     
    elsif keys_entered == '10'
        run_ssh_cmd(hdd_info[9])
    elsif keys_entered == '11'
        run_ssh_cmd(hdd_info[10])
    elsif keys_entered == '12'
        run_ssh_cmd(hdd_info[11])
    elsif keys_entered == '13'
        run_ssh_cmd(hdd_info[12])            
    elsif keys_entered == '14'
        menu_navigator('tools')
    elsif keys_entered == '15'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def get_desired_drive(command)
    answer = 'WAITING...'
    print "The command you requested needs to be run against a certain drive.\nHere is a list of your drives\n"
        Net::SSH.start($ip_address, $user_name, password: $password) do |ssh|
          result = ssh.exec! 'lsscsi'
            #puts result
            File.open $temp_file_hdd, 'w' do |f|
                f.puts(result)
            lines = IO.readlines($temp_file_hdd).map do |line|
            $temp_hdd = Rainbow(line[58..60]).red
          end
    puts "The drive names we're after are listed above the red pointers:   "Rainbow("^^^").red
    puts "They usually start with 'sd' eg. 'sda', 'sdb' and 'sdc . . .'"
    puts "If you enter all 3 letters, i'll procced and by running the test against that drive"
    print "Please enter your selection (eg. 'sda'):"
    $hdd_choice = gets.chomp.to_downcase
    run_ssh_cmd(command)
end

      
      get_temp_list('lsscsi')
    answer = gets.chomp
    if answer != 'WAITING...'
        menu_navigator($current_menu)   
    end
end

# def cpu_menu(keys_entered)
#     cpu = ['lscpu', 'cat /proc/cpuinfo', "egrep --color 'lm|vmx|svm' /proc/cpuinfo" ]
#     menu_length = cpu.length + 2
#     if keys_entered == '1'
#         run_ssh_cmd(cpu[0])
#     elsif keys_entered == '2'
#         run_ssh_cmd(cpu[1])
#     elsif keys_entered == '3'
#         run_ssh_cmd(cpu[2])
#     elsif keys_entered == '4'
#         menu_navigator('tools')
#     elsif keys_entered == '5'
#         menu_navigator('exit')
#     else
#         bad_choice(menu_length)
#     end
# end

# def admin_menu(keys_entered)
#     admin = ['tail -f --lines=99 /var/log/syslog', 'free -l', 'ps -eF', 'ps -eo size,pid,time,args --sort -size', 'testparm -sv', 'w' ]
#     menu_length = admin.length + 2
#     if keys_entered == '1'
#         run_ssh_cmd(admin[0])
#     elsif keys_entered == '2'
#         run_ssh_cmd(madmin[1])
#     elsif keys_entered == '3'
#         run_ssh_cmd(admin[2])
#     elsif keys_entered == '4'
#         run_ssh_cmd(admin[3])
#     elsif keys_entered == '5'
#         run_ssh_cmd(admin[4])
#     elsif keys_entered == '6'
#         run_ssh_cmd(admin[5])
#     elsif keys_entered == '7'
#         run_ssh_cmd(admin[6])
#     elsif keys_entered == '8'
#         menu_navigator('tools')
#     elsif keys_entered == '9'
#         menu_navigator('exit')
#     else
#         bad_choice(menu_length)
#     end
# end

# def misc_menu(keys_entered)
#     misc = ['lspci', 'lspci -vnn', 'lspci -knn', 'lsscsi"', 'lsscsi -vgl', 'lsusb', 'dmidecode', 'sensors', 'sensors-detect', 'ethtool -i eth0', 'openssl version']
#     menu_length = misc.length + 2
#     if keys_entered == '1'
#         run_ssh_cmd(misc[0])
#     elsif keys_entered == '2'
#         run_ssh_cmd(misc[1])
#     elsif keys_entered == '3'
#         run_ssh_cmd(misc[2])
#     elsif keys_entered == '4'
#         run_ssh_cmd(misc[3])
#     elsif keys_entered == '5'
#         run_ssh_cmd(misc[4])
#     elsif keys_entered == '6'
#         run_ssh_cmd(misc[5])
#     elsif keys_entered == '7'
#         run_ssh_cmd(misc[6])
#     elsif keys_entered == '8'
#         run_ssh_cmd(misc[7])
#     elsif keys_entered == '9'
#         run_ssh_cmd(misc[8])
#     elsif keys_entered == '10'
#         run_ssh_cmd(misc[9])
#     elsif keys_entered == '11'
#         run_ssh_cmd(misc[10])
#     elsif keys_entered == '12'
#         run_ssh_cmd(misc[11])
#     elsif keys_entered == '13'
#         menu_navigator('tools')
#     elsif keys_entered == '14'
#         menu_navigator('exit')
#     else
#         bad_choice(menu_length)
#     end
# end

# def mem_menu(keys_entered)
#     memory = ['free', 'free -mt', 'cat /proc/meminfo', 'vmstat -m']
#     menu_length = memory.length + 2
#     if keys_entered == '1'
#         run_ssh_cmd(memory[0])
#     elsif keys_entered == '2'
#         run_ssh_cmd(memory[1])
#     elsif keys_entered == '3'
#         run_ssh_cmd(memory[2])
#     elsif keys_entered == '4'
#         run_ssh_cmd(memory[3])
#     elsif keys_entered == '5'
#         menu_navigator('tools')
#     elsif keys_entered == '6'
#         menu_navigator('exit')
#     else
#         bad_choice(menu_length)
#     end
# end


# $ip_address = '192.168.15.3' # the current ipadress
# $user_name = 'root' # the current user name
# $password = 'y2kvoy36*' # the current password

#     def test_connection(command)
#     Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|
#      command = ssh.exec!command

#     end
# end

# puts 'lsscsi'
# puts 'EXIT!!! <-- to exit'
# command = "dmesg | egrep '(s|h)d[a-z]"
# test_connection(command)
# while command != 'EXIT!!'
#     print ":: "
# user = gets.chomp
# test_connection(user)
# end
# $ip_address = '192.168.15.3' # the current ipadress
# $user_name = 'root' # the current user name
# $password = 'y2kvoy36*' # the current password
# require 'net/ssh'
# $temp_hdd = ''
# $temp_file_hdd = ''
# def get_temp_list(command)

#     $temp_file_hdd = "logs/hdd.log"
#     Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|
#       result = ssh.exec!command
#       puts result

#       File.open $temp_file_hdd , 'w' do |f|
#         f.puts(result)
#       end
#     end

# end

# get_temp_list("lsscsi")

# lines = IO.readlines($temp_file_hdd).map do |line|
#   $temp_hdd = line[58..60]
# end
# File.open $temp_file_hdd, 'w' do |f|
#     f.puts($temp_hdd)
# end

$ip_address = '192.168.15.3' # the current ipadress
$user_name = 'root' # the current user name
$password = 'y2kvoy36*' # the current password
require 'net/ssh'
$temp_hdd = ''
$temp_file_hdd = ''

def get_hdd_names

def get_temp_list(command)
  $temp_file_hdd = 'logs/hdd.log'
  Net::SSH.start($ip_address, $user_name, password: $password) do |ssh|
    result = ssh.exec! command
    File.open $temp_file_hdd, 'w' do |f|
      f.puts(result)
    end
  end
end

get_temp_list('lsscsi')

text = File.open('logs/hdd.log').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
File.open('logs/hdd_t.log', 'w') { |file| file.truncate(0) } # Makes sure temp is emplty before writting to as we need to use add to file (a+) further down because we're printing line by line, else if we set that to write (w) all we get is the last line
  File.open 'logs/hdd_t.log', 'a+' do |f| # prints it 1 line at a time, adding each to the next line
    if line[59] == 'd' # makes sure i get the sd* files not the cdrom
      $temp_hdd = line[58..60] # prints the letters at that
      f.puts($temp_hdd) # finaly saves it
    end
  end
end

end

list = File.open('logs/hdd_t.log').read
puts list


# def misc_menu(keys_entered)
    #     misc = ['lspci', 'lspci -vnn', 'lspci -knn', 'lsscsi"', 'lsscsi -vgl', 'lsusb', 'dmidecode', 'sensors', 'sensors-detect', 'ethtool -i eth0', 'openssl version']
    #     menu_length = misc.length + 2
    #     if keys_entered == '1'
    #         run_ssh_cmd(misc[0])
    #     elsif keys_entered == '2'
    #         run_ssh_cmd(misc[1])
    #     elsif keys_entered == '3'
    #         run_ssh_cmd(misc[2])
    #     elsif keys_entered == '4'
    #         run_ssh_cmd(misc[3])
    #     elsif keys_entered == '5'
    #         run_ssh_cmd(misc[4])
    #     elsif keys_entered == '6'
    #         run_ssh_cmd(misc[5])
    #     elsif keys_entered == '7'
    #         run_ssh_cmd(misc[6])
    #     elsif keys_entered == '8'
    #         run_ssh_cmd(misc[7])
    #     elsif keys_entered == '9'
    #         run_ssh_cmd(misc[8])
    #     elsif keys_entered == '10'
    #         run_ssh_cmd(misc[9])
    #     elsif keys_entered == '11'
    #         run_ssh_cmd(misc[10])
    #     elsif keys_entered == '12'
    #         run_ssh_cmd(misc[11])
    #     elsif keys_entered == '13'
    #         menu_navigator('tools')
    #     elsif keys_entered == '14'
    #         menu_navigator('exit')
    #     else
    #         bad_choice(menu_length)
    #     end
    # end

# File.open('diagram.txt', 'r') do |f|
#     # do something with file
#     File.delete(f)
#   end
# rescue Errno::ENOENT

# lines = IO.readlines($temp_file_hdd).map do |line|
#   $temp_hdd = line[58..60]
# end
# File.open $temp_file_hdd, 'w' do |f|
#     f.puts($temp_hdd)
# end
