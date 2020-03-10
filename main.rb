require 'rainbow' # Ruby Gem
require 'net/ssh' # Rub Gem
require_relative 'lib/terminal-basic-menu' # Ruby Gem
require_relative 'info_get'
require_relative 'connection_test'
# require_relative './SUB_dash_menu.rb'
# require_relative 'SUB_array_menu'
# require_relative 'SUB_array_start_menu'
# require_relative 'SUB_array_stop_menu'
# require_relative 'SUB_main_menu'
# require_relative 'SUB_setup_menu'
# require_relative 'SUB_ssh_menu'
# require_relative 'SUB_start_menu'
# require_relative 'SUB_tools_menu'


$current_menu = "start"
$menu_full_name = 'Start'
$navigator = nil
$ip_address = 'NOT ENTERED'
$user_name = 'NOT ENTERED'
$password = 'NOT ENTERED'
$safe_word = "NOT ENTERED"
$ssh_command = "NOT SELECTED"
$result = "FAIL"
$connect_test_result = "NOT CONNECTED"

def ssh_menu(keys_entered)
    menu_length = 4
    if keys_entered == '1'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '2'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '3'
        menu_navigator('main')
    elsif keys_entered == '4'
        menu_navigator('exit')
    else
    bad_choice(menu_length)
    end  
end

def start_menu(keys_entered)
    menu_length = 2
    if keys_entered == "1"
        menu_navigator("setup")
        elsif keys_entered == "2"
        menu_navigator("exit")
        else
        bad_choice(menu_length)
    end    
end

def array_menu(keys_entered)
    menu_length = 6
    if keys_entered == '1'
        menu_navigator('array_start')
    elsif keys_entered == '2'
        menu_navigator('array_stop')
    elsif keys_entered == '3'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '4'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '5'
        menu_navigator('main')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def array_start_menu(keys_entered)
    menu_length = 5
    if keys_entered == '1'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '2'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '3'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '4'
        menu_navigator('array')
    elsif keys_entered == '5'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def array_stop_menu(keys_entered)
    menu_length = 7
    if keys_entered == '1'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '2'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '3'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '4'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '5'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '6'
        menu_navigator('array')
    elsif keys_entered == '7'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end 
end

def main_menu(keys_entered)
    menu_length = 5
    if keys_entered == "1"
        menu_navigator("setup")
        elsif keys_entered == "2"
        menu_navigator("dash")
        elsif keys_entered == "3"
        menu_navigator("tools")
        elsif keys_entered == "4"
        menu_navigator("array")
        elsif keys_entered == "5"
        menu_navigator("exit")
        else
        bad_choice(menu_length)
    end
end

def setup_menu(keys_entered)
    menu_length = 6
    if keys_entered == "1"
        print "Please enter your UnRaid servers IP address: "
        $ip_address = gets.chomp
        menu_navigator("setup")
    elsif keys_entered == "2"
        print "Please enter your login name: "
        $user_name = gets.chomp
        menu_navigator("setup")
    elsif keys_entered == "3"
        print "Please enter your password: "
        $password = gets.chomp
        $safe_word = "ENTERED"
        menu_navigator("setup")
    elsif keys_entered == "4"
        test_connection()
    elsif keys_entered == "5"
        menu_navigator("main")
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def tools_menu(keys_entered)
    menu_length = 8
    if keys_entered == '1'
        menu_navigator("cpu")
    elsif keys_entered == '2'
        menu_navigator("mem")
    elsif keys_entered == '3'
        menu_navigator("network")
    elsif keys_entered == '4'
        menu_navigator("hdd")
    elsif keys_entered == '5'
        menu_navigator("admin")
    elsif keys_entered == '6'
        menu_navigator("misc")
    elsif keys_entered == '7'
        menu_navigator('main')
    elsif keys_entered == '8'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def dash_menu(keys_entered)
    dash = ["df", "cat /etc/samba/smb-shares.conf", "docker ps"]
    menu_length = dash.length + 3
    if keys_entered == '1'
        run_ssh_cmd(dash[0])
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd(dash[1])
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd(dash[2])
        return_on_enter
    elsif keys_entered == '4'
        dashboard_print
    elsif keys_entered == '5'
        menu_navigator('main')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end    
end

def realy_exit()
    puts "Did you know that everytime this program connects to your server it saves it in multiple logs:"
    puts "Look in the log directory for the log index named: " + Rainbow("ssh_dashboard_master.log").blue.bright
    exit
    # exit(true)
end

def return_on_enter
    return_after_connection = 'WAITING...'
    print "Press ENTER key to return to #{$menu_full_name}"
    return_after_connection = gets.chomp
    if return_after_connection != 'WAITING...'
        menu_navigator($current_menu)
    end
end

def menu_navigator(option)
    if option == 'start'
        body_text = "Welcome, to get started we first need to setup a connection, to do that you'll need the following information handy:\n\n- Your servers IP address;\n- Your username; and\n- Your password"
        body_choices = ['Continue', 'Exit']
        footer_text = "Ready? TYPE '1' then ENTER to continue to the Setup Connection Menu"
        $current_menu = 'start'
        $menu_full_name = 'Welcome Menu'
    elsif option == 'setup'
        body_text = "Please enter the following details:"
        body_choices = ['IP Address: ' + $ip_address, 'User Name: ' + $user_name, 'Password: ' + $safe_word, 'Test Connection: ' +$connect_test_result, 'Continue to Main Menu', 'Exit']
        footer_text = $connect_test_result
        $current_menu = 'setup'
        $menu_full_name = 'Setup Connection Menu'
    elsif option == 'main'
        body_text = "Please enter a selection from the following:"
        body_choices = ['Setup Wizard', 'SSH Dashboard', 'SSH ToolBox', 'Array Tools','Exit']
        footer_text = "Your current location is: /Main Menu/"
        $current_menu = 'main'
        $menu_full_name = 'Home Menu'
    elsif option == "ssh"
        body_text = "How would you like to connect?"
        body_choices = ['Saved Connections', 'New Connection', 'Return to Main Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH Connections"
        $current_menu = 'ssh'
        $menu_full_name = 'SSH Advanced Tool Menu'
    elsif option == 'dash'
        body_text = "What would you like to view?"
        body_choices = ['View Drives', 'View Shares', 'View Docker Services', 'View System Information', 'Rerurn to Main Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/SSH Dashboard"
        $current_menu = 'dash'
        $menu_full_name = 'SSH DashBoard Menu'
    elsif option == "tools" 
        body_text = "What would you like to see information on?"
        body_choices = ['CPU Tools', 'Memory Tools', 'Network Tools', 'Hard Drive Tools','Admin Tools', 'Misc Tools', 'Main Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox"
        $current_menu = 'tools'
        $menu_full_name = 'SSH ToolBox Menu'
    elsif option == "array_stop"
        body_text = "To cleanly stop the array prior to a reboot requires the following in turn.\nFailure to carry out these steps will result in the array requiring being rebuilt and depending on the size of your array this could take days, so please don't skip a step:"
        body_choices = ['First: Stop the SAMBA serivce', 'Second: UnMount drives', 'Third: Stop the UnRaid server', 'Reboot Server','Shut Down Server', 'Return to Array Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/Array tools/Stop the Array"
        $current_menu = 'array_stop'
        $menu_full_name = 'UnRaid Array Stop Menu'
    elsif option == "array_start"
        body_text = "To start the array requires the following in turn.\nPlease don't skip any steps:"
        body_choices = ['First: Start the UnRaid server', 'Second: Mount drives', 'Third: Start the SAMBA serivce', 'Return to Array Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/Array tools/Start the Array"
        $current_menu = 'array_start'
        $menu_full_name = 'UnRaid Array Start Menu'
    elsif option == "array"
        body_text = "What would you like to do?"
        body_choices = ['Start the Array', 'Stop the Array', 'Reboot Server','Shut Down Server', 'Return to Main Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/Array tools"
        $current_menu = 'array'
        $menu_full_name = 'UnRaid Array Controls Home Menu'
    elsif option == "cpu" 
        body_text = "What would you like to run?"
        body_choices = ['Short summary of CPU info', 'Much longer report of all CPUs', 'Check for 64bit mode support and CPU virtualization support', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Tools Menu"
        $current_menu = 'cpu'
        $menu_full_name = 'CPU Tools Menu'
    elsif option == "network" 
        body_text = "What would you like to see information on?"
        body_choices = ['Lists the installed kernel modules, including your network driver', 'Display the network driver being used by your network chipset and its version', 'Displays settings for network chipset eg speed setting, gigabit connection, Wake-on-LAN', 'Parameters and statistics eg MAC address, transmit/receive statistics, including errors and collisions','Display more detailed network statistics', 'Check for correct nameserver and DNS configuration', 'Another way to check for correct nameserver configuration', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Network Tools Menu"
        $current_menu = 'network'
        $menu_full_name = 'Network Tools Menu'
    elsif option == "hdd" 
        body_text = "What would you like to see information on?"
        body_choices = ['View the identity and configuration information for a drive', 'Determine the read speed of a hard drive', 'STMART info for a drive: identity,configuration info, physical statistics and error history', 'Some newer drives and disk controllers will not issue a report if you use the -d ata option','Short SMART test on a drive (short test takes minutes)', 'Long SMART test on a drive, (long test can take several hours)', 'To view the partitioning of a drive,geometry and sectors', 'To obtain the total number of sectors on a drive', 'To verify how the drive is labeled', 'Drives by model, serial number drive device ID (sda, hdc, etc) linked to each', 'Drives by model, serial number deviceID and links', 'Drive devices with volume labels and device ID: Typically, only the flash drive', 'Reports file system disk space usage', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Hard Drive Tools Menu"
        $current_menu = 'hdd'
        $menu_full_name = 'Hard Drive Tools Menu'
    elsif option == "admin" 
        body_text = "What would you like to see information on?"
        body_choices = ['Display current end of syslog', 'List processes similar to top', 'List the processes on the server and their memory size sorted', 'Show system configuration parameters, including security and permissions','Show who is logged on and what they are doing', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Admin Tools Menu"
        $current_menu = 'admin'
        $menu_full_name = 'Admin Tools Menu'
    elsif option == "misc" 
        body_text = "What would you like to see information on?"
        body_choices = ['Displays information about PCI buses and devices', 'Displays more verbose information about PCI buses and devices', 'Displays even more information about PCI buses and devices including device numbers and assigned kernel modules', 'Displays information about SCSI devices','Displays more verbose information about SCSI devices, including ATA numbers', 'Displays information about USB buses and the devices connected to them', 'Displays the raw information from DMI/SMBIOS tables', 'Displays available sensor info (CPU, drive temperatures, system voltages, fan speeds)', 'Analyses system and displays all available sensors and needed modules, requires Perl installed first', 'Displays the Linux kernel version', 'Displays the version of the network driver being used by your network chipset (for eth0)', 'Displays the version of OpenSSL', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Misc Menu"
        $current_menu = 'misc'
        $menu_full_name = 'Misc Tools Menu'
    elsif option == "mem" 
        body_text = "What would you like to see information on?"
        body_choices = ['Abbreviated summary of general memory info', 'Summary of general memory info with totals', 'Summary of general memory info with totals, all in megabytes', 'A more complete report of memory usage','Displays virtual memory statistics', 'Detailed virtual memory usage', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Memory Tools Menu"
        $current_menu = 'mem'
        $menu_full_name = 'Memory Tools Menu'
    elsif option == "exit"
        realy_exit()
    end
    header_text = 'UnRaid SSH Dashboard v0.2'
    # ADD ONCE CHANGED TO NEW SEARCH::   footer_text = "Your current location is /#{$current_menu}/#{menu_return_to_previous[menu_full_name]}/"
    header = { text: header_text, color: :red }
    body = {text: body_text, choices: body_choices, align: 'center', color: :white }
    footer = { text: footer_text, align: 'center', color: :blue }    
    menu1 = Menu.new(header: header, body: body, footer: footer, width: 80)
    menu1.border_color = :green
    system('clear')
    menu1.display_menu
end

def dashboard_print
    print " > > > "
    puts Rainbow("System Information:\n").blue.underline
    run_ssh_cmd("uname -a")
    print "\n > > > "
    puts Rainbow("UnRaid Version:\n").silver.underline
    run_ssh_cmd("cat /etc/unraid-version")
    print "\n > > > "
    puts Rainbow("Public IP Address:\n").yellow.underline
    run_ssh_cmd("net lookup google.com")
    print "\n > > > "
    puts Rainbow("CPU Status:\n").magenta.underline
    run_ssh_cmd("sensors")
    print "\n > > > "
    puts Rainbow("Memory Status:\n").aqua.underline
    run_ssh_cmd("free -t")
    print "\n > > > "
    puts Rainbow("Current Users:\n").indianred.underline
    run_ssh_cmd("w")
    return_on_enter
end

def keys_entered_decrypter(keys_entered)
    if $current_menu == "main"
        main_menu(keys_entered)
    elsif $current_menu == "start"
        start_menu(keys_entered)
    elsif $current_menu == "setup"
        setup_menu(keys_entered)
    elsif $current_menu == 'ssh'
        ssh_menu(keys_entered)
    elsif $current_menu == 'dash'
        dash_menu(keys_entered)
    elsif $current_menu == 'tools'
        tools_menu(keys_entered)
    elsif $current_menu == 'array'
        array_menu(keys_entered)
    elsif $current_menu == 'array_stop'
        array_stop_menu(keys_entered)
    elsif $current_menu == 'array_start'
        array_start_menu(keys_entered)
    end
end

def bad_choice(menu_length)
    wrong_selection = 'INCORRECT...'
    print "I didn't recognise that selection, please select a number between 1 and #{menu_length}\nPress the ENTER key to return to #{$menu_full_name} and try again . . . ."
    wrong_selection = gets.chomp
    if wrong_selection != 'INCORRECT...'
        menu_navigator($current_menu)   
    end
end

menu_navigator($current_menu)
while $current_menu != 'exit' do
    print "Please make a selection: "
    key_input = gets.chomp
    keys_entered_decrypter(key_input)
end
