require 'rainbow' # gem
require 'net/ssh' # gem
require 'tty/pie' # gem which was to display pie charts of hdd space remaining, ram used, proccessor cores used, but i didn't get it done in time.
require_relative 'lib/terminal-basic-menu' # gem


$current_menu = "start" # stores current menu so LIST DEFS know what to do
$menu_full_name = 'Start' # Full menu name, for promts to retup
$navigator = nil
$ip_address = 'NOT ENTERED' # the current ipadress
$user_name = 'NOT ENTERED' # the current user name
$password = '' # the current password
$safe_word = "ENTERED" # to hide password on setup screen
$ssh_command = "NOT SELECTED" # not used currently
$result = "FAIL" # not used currently
$connect_test_result = "NOT CONNECTED" # shows if test connect worked
$temp_hdd = 'logs/temp1.log' # used in hard drive tools
$temp_file_hdd = 'logs/temp2.log' # as above both needed 
$hdd_choice = '' # for storing of hard drive that user wants to scan, mount, unmount eg 'sda' 'sdb' etc...

def test_connection(command) # Confirms connection by checking the directory (pwd) that you log in as (users normally start in their home directory eg. Login in as root the default directory should be root/
    Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|  # THIS CONNECTS TO SERVER
      $result = ssh.exec!command # SENDS COMMAND WHICH IS: PWD
    end
  if $result.gsub(/[^0-9A-Za-z]/, '') == $user_name # REMOVES THE SLASH FROM THE PWD COMMAND AND COMAPARES TO USER NAME, THEY SHOULD BE THE SAME
      $connect_test_result = "Connection Succesful" # SETS THE VALUE TO THE FOOTER TO CONNECTION SUCCESFULL
      puts "Status: Connection with UnRaid server Succesful" # TELLS USER THAT IT CONNECTED
  else
      puts "Connection Failed, please check your settings..." # TELLS THAT IT FAILED
  end
  return_on_enter # STOPS THE PROGRAM FROM RETURNING TO CMD LINE
    # I KNOW THAT THERE IS A WAY TO READ SUCCESSFUL OR UNSUSSESSFUL RESULTS IT JUST WENT A BIT OVER MY HEAD WHEN TRYING TO GET TO WORK,
    # PROBABLY REAL EASY THOUGH, I ALWAYS SEAM TO GET STUCK ON BASIC THINGS LOL THAT I SHOULD KNOW... 
end

# Runs the ssh command (BELLOW)
# Returns result to user
# Saves the returned information from server
# Creates or Adds to: 2 log files in the log directory:
#     1. Named after the command used, this contains: 
#           - The command used
#           - The commands output
#           - The local server and client time
#           - The account used
#           - IP address used to access
#           - NAMED: ssh_dashboard_(COMMAND_USED).log
#     2. A Master Log named 'ssh_dashboard_master.log'
#           - The account used
#           - Client time
#           - Command used
# Removes special characters from the command so when naming the log it's not a invalid filename

def run_ssh_cmd(command) #gem but with alot of extra stuff going on (see above), ln 45, 48, 49, 55, 60 are the closest to original gem
    local_time = Time.now.to_s # gets time for the logs
    log_file_name = "logs/ssh_dashboard_#{command.gsub(/[^0-9A-Za-z]/, '')}.log" # makes the log named after the command run removing any characters that would make a error
    Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|  # connect to ssh gem
      $result = ssh.exec!command # runs the command and puts it into the result value
      puts $result # prints the result for the user on screen
      result_log = "-->> NEW ENTRY created by USER: #{$user_name} via GATEWAY: #{$ip_address} \n-->> SSH-Client executed the following COMMAND: #{command}   \n-->> Local server TIME: " + ssh.exec!("date\necho\n") + $result + "\n-->> END OF ENTRY at SSH-Client Time: #{local_time} \n\n" # adds the time, user, ipadress, command and result togeather for log
      File.open log_file_name, 'a+' do |f| # creates the log or adds (a+) the results to the log
         f.puts(result_log) # pushes the info to the log
      end

    end        
    master_log = "AT: #{local_time} --> USER: #{$user_name} --> INIT_CMD: #{command} --> SEE_LOG: #{log_file_name}" # adds time, user, file name and command into value to print into the log
      File.open "logs/ssh_dashboard_master.log", 'a+' do |f| # creates or adds to the log
        f.puts(master_log) # pushes the info to the master log
      end
end

def cheat_codes(code) # for debugging prints what the $ are set too, lets you go to any menu (but the menu is then buggy as it never got the right variables)
    if code == 'idkfa' # the code entered, this one prints the $values to help diagnose
        puts Rainbow("\nAll Ammo + Keys\n").indianred.underline
        print '$current_menu: '
        puts $current_menu
        print '$menu_full_name: '
        puts $menu_full_name
        print '$navigator: '
        puts $navigator
        print '$ip_address: '
        puts $ip_address
        print '$user_name: '
        puts $user_name
        print '$password: '
        puts $password
        print '$safe_word: '
        puts $safe_word
        print 'ssh_command: '
        puts $ssh_command
        print '$result: '
        puts $result
        print 'connect_test_result: '
        puts $connect_test_result
    elsif code == 'idclip' # this code lets you jump to other menus
        puts Rainbow("\nNo-Clip:\n").indianred.underline
        menu_index = [ 'start', 'setup_new', 'main', 'saved_ssh', 'dash', 'tools', 'array_stop', 'array_start', 'array_main', 'cpu', 'mem', 'network', 'hdd', 'admin', 'misc' ]
        puts menu_index
        print Rainbow("exit\n").yellow
        print Rainbow("IDCLIP MODE: ").red
        $current_menu = gets.chomp
        menu_navigator($current_menu) # tells the navigator to open the menu entered
    end
end
# BELLOW IS TO UNDERSTAND WHAT IS GOING ON IN THE MENUS INSTEAD OF REPEATING THIS OVER AND OVER BELLOW
# def SAMPLE(USERS_KEY_ENTERED) <----- ssh menu runs the option, gets selection from the decipher
#     SAMPLE_COMMANDS = ['pwd', 'ls']
#     menu_length = 4 <---- THE LENGTH OF MENU TO PREVENT OTHER NUMBERS BEING ENTERED
#     if keys_entered == '1' <----- NUMBER 1 PRESSED
#         puts 'SAMPLE' <----- WOULD PRINT THIS ON SCREEN
#         return_on_enter <--------- STOPS THE PROGRAM FROM ENDING TO PROMPT
#     elsif keys_entered == '2' <----- Number 2 PRESSED
#         menu_navigator("dash") <------ tells menu navigator to goto dash menu
#     elsif keys_entered == '3' <------- Number 3 PRESSED
#         run_ssh_cmd(SAMPLE_COMMANDS[0]) <------ RUNS 1st command in SAMPLE_COMMANDS eg in this sample 'pwd'
#         retern_on_enter <----- PREVENTS PROGRAM FROM GOING TO PROMPT ALSO SHOWS ENTER TO RETERN
#     elsif keys_entered == '4' <----- NUMBER 4 ENTERED
#         menu_navigator('exit') <------ TELLS menu_naviagtor that the user wants to EXIT
#     else
#     bad_choice(menu_length) <--- IF INCORRECT OPTION ENTERED THIS RESPONDS TO THAT
# end  

def hdd(keys_entered) # HDD TOOLS MENU -- SEE LINE 103 FOR MENU EXPLINATIONS
    hdd_info = ["hdparm  -I  /dev/#{$hdd_choice}", "hdparm  -tT  /dev/#{$hdd_choice}", "smartctl  -a  -d  ata  /dev/#{$hdd_choice}", "smartctl -a /dev/#{$hdd_choice}", "smartctl  -d  ata  -tshort  /dev/#{$hdd_choice}", "smartctl  -d  ata  -tlong  /dev/#{$hdd_choice}", "fdisk  -l  -u  /dev/#{$hdd_choice}", "blockdev  --getsz  /dev/#{$hdd_choice}", "vol_id  /dev/#{$hdd_choice}1", "ls  -l  /dev/disk/by-id", "ls  -l  /dev/disk/by-id/[au]*  |  grep  -v  part1 ", "ls  -l  /dev/disk/by-label", "df"]
        menu_length = hdd_info.length + 2
        if keys_entered == '1'
            get_desired_drive(hdd_info[0])
            return_on_enter
        elsif keys_entered == '2'
            get_desired_drive(hdd_info[1])
            return_on_enter
        elsif keys_entered == '3'
            get_desired_drive(hdd_info[2])
            return_on_enter
        elsif keys_entered == '4'
            get_desired_drive(hdd_info[3])
            return_on_enter
        elsif keys_entered == '5'
            rget_desired_drive(hdd_info[4])
            return_on_enter
        elsif keys_entered == '6'
            get_desired_drive(hdd_info[5])
            return_on_enter
        elsif keys_entered == '7'
            get_desired_drive(hdd_info[6])
            return_on_enter
        elsif keys_entered == '8'
            rget_desired_drive(hdd_info[7])
            return_on_enter
        elsif keys_entered == '9'
            get_desired_drive(hdd_info[8])
            return_on_enter
        elsif keys_entered == '10'
            run_ssh_cmd(hdd_info[9])
            return_on_enter
        elsif keys_entered == '11'
            run_ssh_cmd(hdd_info[10])
            return_on_enter
        elsif keys_entered == '12'
            run_ssh_cmd(hdd_info[11])
            return_on_enter
        elsif keys_entered == '13'
            run_ssh_cmd(hdd_info[12])
            return_on_enter
        elsif keys_entered == '14'
            menu_navigator('tools')
        elsif keys_entered == '15'
            menu_navigator('exit')
        else
            bad_choice(menu_length)
        end
end
    
def get_desired_drive(command) # Asks user to pick whitch drive they want to scan with the hdd tools
#      answer = 'WAITING...'
    print "The command you requested needs to be run against a certain drive.\nHere is a list of your drives\n"
        Net::SSH.start($ip_address, $user_name, password: $password) do |ssh| # CONNECTS TO SSH
          result = ssh.exec! 'lsscsi' # RUNS THE COMMAND TO LIST DRIVES
            # puts result
            File.open $temp_file_hdd, 'w' do |f| # SAVES IT, OVERRIDES OLD IF IT EXISTS
                f.puts(result) # PUSHES IT TO FILE
            end
            lines = IO.readlines($temp_file_hdd).map do |line| # OPENS THE FILE TO SEARCH FOR THE ROW WE WANT
                if line[58..59] = 'sd' # gets rid of most unwanted drives TAKES OFF DRIVES THAT ARN'T WHAT WE WANT
                    puts  line[0..57] + Rainbow(line[58..60]).purple # highlights drives to make it even more user friendly PRINTS THE LIST
                end
          end
          end
    puts "The drive names we're after are listed above in " + Rainbow("pink").purple.underline # explains whats going on
    puts "They 'sd' and end in a leter eg: 'sda', 'sdb' and 'sdc' etc . . .\nIf you see one with Udisk in its name, that is the UnRaid Boot USB drive\nIf you enter all 3 letters, of the drive you want to check\ni'll procced by running the test against that drive"
    print "Please enter your selection (eg. 'sda'): "
    $hdd_choice = gets.chomp # GETS USER TO ENTER THEIR CHOICE AND SETS $hhd_choice to it as the command coming in has #{$hdd_choice} in its value
    run_ssh_cmd(command) # SENDS TO run_ssh_cmd to do its usual job of running commands and logging them
end

# def ssh_menu(keys_entered) # ssh menu runs the option, gets selection from the decipher NOT USED AT THE MOMENT -- SEE LINE 103 FOR MENU EXPLINATIONS
#     menu_length = 4
#     if keys_entered == '1'
#         puts 'NOT SETUP YET PRESSED 1'
#     elsif keys_entered == '2'
#         puts 'NOT SETUP YET PRESSED 1'
#     elsif keys_entered == '3'
#         menu_navigator('main')
#     elsif keys_entered == '4'
#         menu_navigator('exit')
#     else
#     bad_choice(menu_length)
#     end  
# end

def start_menu(keys_entered) # start menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    menu_length = 2
    if keys_entered == "1"
        menu_navigator("setup")
        elsif keys_entered == "2"
        menu_navigator("exit")
        else
        bad_choice(menu_length)
    end    
end

def array_menu(keys_entered) # array main menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    menu_length = 6
    if keys_entered == '1'
        menu_navigator('array_start')
    elsif keys_entered == '2'
        menu_navigator('array_stop')
    elsif keys_entered == '3'
        run_ssh_cmd(network['reboot')
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd(network['poweroff')
        return_on_enter
    elsif keys_entered == '5'
        menu_navigator('main')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def array_start_menu(keys_entered) # array start menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    menu_length = 5
    if keys_entered == '1'
        run_ssh_cmd('/root/mdcmd start')
        return_on_enter
    elsif keys_entered == '2'
        get_desired_drive('mount /dev/#{$hdd_choice}') # sends the user to the hard drive picker tool to nmount drives
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd('/root/samba start')
        return_on_enter
    elsif keys_entered == '4'
        menu_navigator('array')
    elsif keys_entered == '5'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def array_stop_menu(keys_entered) # array stop menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    menu_length = 7
    if keys_entered == '1'
        run_ssh_cmd('/root/samba stop')
        return_on_enter
    elsif keys_entered == '2'
        get_desired_drive('umount /dev/#{$hdd_choice}') # sends the user to the hard drive picker tool to unmount drives
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd('/root/mdcmd stop')
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd('reboot')
        return_on_enter
    elsif keys_entered == '5'
        run_ssh_cmd('poweroff')
        return_on_enter
    elsif keys_entered == '6'
        menu_navigator('array')
    elsif keys_entered == '7'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end 
end

def main_menu(keys_entered) # main menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
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

def setup_menu(keys_entered) # setup menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
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
        test_connection('pwd')
    elsif keys_entered == "5"
        menu_navigator("main")
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def tools_menu(keys_entered) # toolbox menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
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

def dash_menu(keys_entered) # dashboard menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
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

def network(keys_entered) # toolbox network menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    network = ['lsmod', 'ethtool -i eth0', 'ethtool eth0', 'ifconfig', 'ethtool -S eth0', 'net lookup google.com', 'ping -c5 google.com' ]
    menu_length = network.length + 2
    if keys_entered == '1'
        run_ssh_cmd(network[0])
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd(network[1])
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd(network[2])
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd(network[3])
        return_on_enter
    elsif keys_entered == '5'
        run_ssh_cmd(network[4])
        return_on_enter
    elsif keys_entered == '6'
        run_ssh_cmd(network[5])
        return_on_enter
    elsif keys_entered == '7'
        run_ssh_cmd(network[6])
        return_on_enter
    elsif keys_entered == '8'
        menu_navigator('tools')
    elsif keys_entered == '9'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end    

def cpu(keys_entered) # toolbox cpu menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    cpu = ['lscpu', 'cat /proc/cpuinfo', "egrep --color 'lm|vmx|svm' /proc/cpuinfo" ]
    menu_length = cpu.length + 2
    if keys_entered == "1"
        run_ssh_cmd(cpu[0])
        return_on_enter
    elsif keys_entered == "2"
        run_ssh_cmd(cpu[1])
        return_on_enter
    elsif keys_entered == "3"
        run_ssh_cmd(cpu[2])
        return_on_enter
    elsif keys_entered == "4"
        menu_navigator('tools')
    elsif keys_entered == "5"
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end
        
def admin(keys_entered) # toolbox admin menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    admin = ['ps -eF', 'ps -eo size,pid,time,args --sort -size', 'testparm -sv', 'w' ]
    menu_length = admin.length + 2
    if keys_entered == '1'
        run_ssh_cmd(admin[0])
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd(madmin[1])
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd(admin[2])
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd(admin[3])
    elsif keys_entered == '5'
        menu_navigator('tools')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end
        
def misc(keys_entered) # toolbox misc menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    misc = ['lspci', 'lspci -vnn', 'lspci -knn', 'lsscsi"', 'lsscsi -vgl', 'lsusb', 'dmidecode', 'sensors', 'sensors-detect', 'ethtool -i eth0', 'openssl version']
    menu_length = misc.length + 2
    if keys_entered == '1'
        run_ssh_cmd(misc[0])
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd(misc[1])
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd(misc[2])
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd(misc[3])
        return_on_enter
    elsif keys_entered == '5'
        run_ssh_cmd(misc[4])
        return_on_enter
    elsif keys_entered == '6'
        run_ssh_cmd(misc[5])
        return_on_enter
    elsif keys_entered == '7'
        run_ssh_cmd(misc[6])
        return_on_enter
    elsif keys_entered == '8'
        run_ssh_cmd(misc[7])
        return_on_enter
    elsif keys_entered == '9'
        run_ssh_cmd(misc[8])
        return_on_enter
    elsif keys_entered == '10'
        run_ssh_cmd(misc[9])
        return_on_enter
    elsif keys_entered == '11'
        run_ssh_cmd(misc[10])
        return_on_enter
    elsif keys_entered == '12'
        menu_navigator('tools')
    elsif keys_entered == '13'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def mem(keys_entered) # toolbox memory menu runs the option, gets selection from the decipher -- SEE LINE 103 FOR MENU EXPLINATIONS
    memory = ['free', 'free -mt', 'cat /proc/meminfo', 'vmstat -m']
    menu_length = memory.length + 2
    if keys_entered == '1'
        run_ssh_cmd(memory[0])
        return_on_enter
    elsif keys_entered == '2'
        run_ssh_cmd(memory[1])
        return_on_enter
    elsif keys_entered == '3'
        run_ssh_cmd(memory[2])
        return_on_enter
    elsif keys_entered == '4'
        run_ssh_cmd(memory[3])
        return_on_enter
    elsif keys_entered == '5'
        menu_navigator('tools')
    elsif keys_entered == '6'
        menu_navigator('exit')
    else
        bad_choice(menu_length)
    end
end

def realy_exit() # exit command
    puts "Did you know that everytime this program connects to your server it saves it in multiple logs:" # highlights the log files
    puts "Look in the log directory for the log index named: " + Rainbow("ssh_dashboard_master.log").blue.bright
    exit(true) # exits
end

def return_on_enter # this makes the promt wait after running a terminal command until pressing enter, so the user can review the info
    return_after_connection = 'WAITING...'
    print "Press ENTER key to return to #{$menu_full_name}" # SHOWS WHERE YOU CAME FROM
    return_after_connection = gets.chomp # IF USER ENTERS ANYTHING ILL SET OFF BELLOW IF STATEMENT (unless they somehow put in 'WAITING...')
    if return_after_connection != 'WAITING...' # CHECKING FOR IT NOT BEING THIS
        menu_navigator($current_menu) # TELLS MENU NAVIGATOR TO SEND YOU TO THE MENU USER JUST CAME FROM
    end
end

def menu_navigator(option) # this has all the menu lists, part of the Gem: terminal-basic-menu, with the original code everything was in this, and this then became a very very long option, i don't think it was built for the amount i put in it
    if option == 'start' # WHAT MENU USER HAS REQUESTED
        body_text = "Welcome, to get started we first need to setup a connection, to do that you'll need the following information handy:\n\n- Your servers IP address;\n- Your username; and\n- Your password" # TOP LINES OF MENU
        body_choices = ['Continue', 'Exit'] # THE OPTIONS IN THE MENU
        footer_text = "Ready? TYPE '1' then ENTER to continue to the Setup Connection Menu" # TEXT AT BOTTOM OF MENU
        $current_menu = 'start' # SETS $current_menu TO THE MENU JUST TO MAKE SURE USER DOESN'T GET LOST
        $menu_full_name = 'Welcome Menu' # USED TO MAKE THE PRESS ENTER TO RETURN PROMPTS
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
        $current_menu = "dash"
        $menu_full_name = 'SSH DashBoard Menu'
    elsif option == "tools" 
        body_text = "What would you like to see information on?"
        body_choices = ['CPU Tools', 'Memory Tools', 'Network Tools', 'Hard Drive Tools','Admin Tools', 'Misc Tools', 'Main Menu', 'Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox"
        $current_menu = "tools"
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
    elsif option == 'cpu'
        body_text = "What would you like to run?"
        body_choices = ['Summary of CPU info', 'Longer report of all CPUs', 'Check for 64bit and virtualization support', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Tools Menu"
        $current_menu = 'cpu'
        $menu_full_name = 'CPU Tools Menu'
    elsif option == "network" 
        body_text = "What would you like to see information on?"
        body_choices = ['Lists the installed kernel modules', 'including your network driver', 'Display the network driver being used by your network chipset and its version', 'Displays settings for network chipset eg speed setting, gigabit connection, Wake-on-LAN', 'Parameters and statistics eg MAC address, transmit/receive statistics', 'including errors and collisions','Display more detailed network statistics', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Network Tools Menu"
        $current_menu = "network"
        $menu_full_name = 'Network Tools Menu'
    elsif option == "hdd" 
        body_text = "What would you like to see information on?"
        body_choices = ['View the identity and configuration information for a drive', 'Determine the read speed of a hard drive', 'STMART info for a drive: identity,configuration info, physical statistics and error history', 'Some newer drives and disk controllers will not issue a report if you use the -d ata option','Short SMART test on a drive (short test takes minutes)', 'Long SMART test on a drive, (long test can take several hours)', 'To view the partitioning of a drive,geometry and sectors', 'To obtain the total number of sectors on a drive', 'To verify how the drive is labeled', 'Drives by model, serial number drive device ID (sda, hdc, etc) linked to each', 'Drives by model, serial number deviceID and links', 'Drive devices with volume labels and device ID: Typically, only the flash drive', 'Reports file system disk space usage', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Hard Drive Tools Menu"
        $current_menu = "hdd"
        $menu_full_name = 'Hard Drive Tools Menu'
    elsif option == "admin" 
        body_text = "What would you like to see information on?"
        body_choices = ['List current processes', 'List the processes on the server and their memory size sorted', 'Show system configuration parameters, including security and permissions','Show who is logged on and what they are doing', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Admin Tools Menu"
        $current_menu = "admin"
        $menu_full_name = 'Admin Tools Menu'
    elsif option == "misc" 
        body_text = "What would you like to see information on?"
        body_choices = ['Displays information about PCI buses and devices', 'Displays more verbose information about PCI buses and devices', 'Displays even more information about PCI buses and devices including device numbers and assigned kernel modules', 'Displays information about SCSI devices', 'Displays more verbose information about SCSI devices including ATA numbers', 'Displays information about USB buses and the devices connected to them', 'Displays the raw information from DMI/SMBIOS tables', 'Displays available sensor info (CPU, drive temperatures, system voltages, fan speeds)', 'Displays the Linux kernel version', 'Displays the version of the network driver being used by your network chipset (eth0)', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/CPU Misc Menu"
        $current_menu = "misc"
        $menu_full_name = 'Misc Tools Menu'
    elsif option == "mem" 
        body_text = "What would you like to see information on?"
        body_choices = ['Abbreviated summary of general memory info', 'Summary of general memory info with totals', 'Summary of general memory info with totals, all in megabytes', 'A more complete report of memory usage', 'Return to SSH ToolBox Menu','Exit']
        footer_text = "Your current location is: /Main Menu/SSH ToolBox/Memory Tools Menu"
        $current_menu = "mem"
        $menu_full_name = 'Memory Tools Menu'
    elsif option == "exit"
        realy_exit()
    end
    header_text = "+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+-+\n|U|N|R|A|I|D| |S|S|H| |D|A|S|H|B|O|A|R|D|\n+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+-+"                                                                                                                                                      
    # header_text = ADDS HEADER TEXT
    # ADD ONCE CHANGED TO NEW SEARCH::   footer_text = "Your current location is /#{$current_menu}/#{menu_return_to_previous[menu_full_name]}/"
    header = { text: header_text, color: :magenta } # OPTIONS FOR HEADER
    body = {text: body_text, choices: body_choices, align: 'center', color: :white } # OPTIONS FOR BODY
    footer = { text: footer_text, align: 'center', color: :yellow }    # OPTIONS FOR FOOTER
    menu1 = Menu.new(header: header, body: body, footer: footer, width: 100) # MAKES THE WHOLE MENU WITH THE SETTINGS
    menu1.border_color = :blue # BORDER COLOR
    system('clear') # CLEARS THE SCREEN
    menu1.display_menu # SHOWS THE MENU
end

# def get_dash_private_ssh(command) # NOT USED AT MOMENT WAS TO PRINT THE PI CHARTS OF REMAINING HDD INFO

    # temp = 'logs/temp_dash.log'
    #  result = 'logs/temp2_dash.log'
    # memory_pi =Hash.new
    # memory_total = memory_total
    # memory_used = memory_used    
    # memory_pi = [{name: 'Memory used', value: memory_used / memory_total, color: :blue, fill: '+'}]
       

            # Net::SSH.start($ip_address, $user_name, password: $password) do |ssh|
            #   result = ssh.exec!command
            #    puts result
            # end
                
                #  File.open 'logs/temp2.log', 'w' do |f|
                #      f.puts(result)
                #      result.map{|s|s.split(/[,: ]/)}
                #      puts result
                #      puts lines[1]
                #   end
                    

            
            # if command == 'free -t'
                # lines = IO.readlines("/Users/chris/Coder Academy/ruby/unraid_ssh_dashboard/logs/temp2.log")[3..3]
        
                #  array = lines.split[(/ /)]
                # lines.gsub(/\s+/m, ' ').strip.split(" ")
# lines.split(" ")
# puts array
# lines.first.split(/[,:]/)               



                # puts line2
                    # puts memory_total = line[11-18]
                    # puts memory_used = line[24-30]
                    # persent = memory_used/memory_total
                    # puts persent
                    # puts result
                    # puts memory_total
                    # puts memory_used
                    # gets.chomp
                    #pie_chart = TTY::Pie.new(data: memory_pi)
                   # print pie_chart

# end

def dashboard_print # prints the dashboard overview screen
    print " > > > " # HEADING
    puts Rainbow("System Information:\n").blue.underline # HEADING
    run_ssh_cmd("uname -a") # THE COMMAND IT RUNS 
    print "\n > > > " # BELLOW IS AS ABOVE REPEAT
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
    return_on_enter # KEEPS SCREEN OPEN TILL ENTER
end

def keys_entered_decrypter(keys_entered) # sends the keys pressed to the right menu
    if $current_menu == "main" # FIND OUT THE MENU USER IS IN TO KNOW WHERE TO SEND THE KEY ENTERED
        main_menu(keys_entered) # SENDS THE KEY TO THE MENU
    elsif $current_menu == "start" # AND IT JUST CONTINUES AS ABOVE
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
    elsif $current_menu == 'cpu'
        cpu(keys_entered)
    elsif $current_menu == 'mem'
        mem(keys_entered)
    elsif $current_menu == 'network'
        network(keys_entered)
    elsif $current_menu == 'hdd'
        hdd(keys_entered)
    elsif $current_menu == 'admin'
        admin(keys_entered)
    elsif $current_menu == 'misc'
        misc(keys_entered)
    end
end

def bad_choice(menu_length) # To respond to unknown entries eg errors
    wrong_selection = 'INCORRECT...'
    print "I didn't recognise that selection, please select a number between 1 and #{menu_length}\nPress the ENTER key to return to #{$menu_full_name} and try again . . . ."
    wrong_selection = gets.chomp # ABOVE TELLS USER THE OPTIONS THEY HAVE 1 to menu length AND MENU THEY CAME FROM
    if wrong_selection != 'INCORRECT...' # WAITS FOR ANSWER
        menu_navigator($current_menu)   # SENDS BACK TO MENU THAT THEY CAME FROM
    end
end

menu_navigator($current_menu) # Starts the whole thing running

while $current_menu != 'exit' do # Keeps program from closing after selecting a option
    print "Please make a selection: " # THE PROMPT THAT TAKES ALL THE INFO
    key_input = gets.chomp
    if key_input == "idkfa" || key_input == "idclip" # CHEAT CODES DEBUG MENUS
        cheat_codes(key_input) # IF CHEATS WERE ENTERED SENDS TO CHEAT MENU
    else    
    keys_entered_decrypter(key_input) # ELSE SENDS TO THE KEY ENTERED TO DECRYPTER TO SEND TO RIGHT MENU
    end    
end
