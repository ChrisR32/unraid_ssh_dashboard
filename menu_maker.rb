# Master Menus
# Need to make first one less repeaty
def make_top_menu(menu_key)
    if menu_key == 'start'
        body_text = master_start[0]
        body_choices = master_start[1]
        $current_menu = master_start[2]
        $menu_full_name = master_start[3]
    elsif menu_key == 'setup_new'
        body_text = master_setup_new[0]
        body_choices = master_setup_new[1]
        $current_menu = master_setup_new[2]
        $menu_full_name = master_setup_new[3]
    elsif menu_key == 'main'
        body_text = master_main[0]
        body_choices = master_main[1]
        $current_menu = master_main[2]
        $menu_full_name = master_main[3]
    elsif menu_key == 'saved_ssh'
        body_text = master_saved_ssh[0]
        body_choices = master_saved_ssh[1]
        $current_menu = master_saved_ssh[2]
        $menu_full_name = master_saved_ssh[3]
    elsif menu_key == 'dash'
        body_text = master_dash[0]
        body_choices = master_dash[1]
        $current_menu = master_dash[2]
        $menu_full_name = master_dash[3]
    elsif menu_key == 'tools'
        body_text = master_tools[0]
        body_choices = master_tools[1]
        $current_menu = master_tools[2]
        $menu_full_name = master_tools[3]
    elsif menu_key == 'array_stop'
        body_text = master_array_stop[0]
        body_choices = master_array_stop[1]
        $current_menu = master_array_stop[2]
        $menu_full_name = master_array_stop[3]
    elsif menu_key == 'array_start'
        body_text = master_array_start[0]
        body_choices = master_array_start[1]
        $current_menu = master_array_start[2]
        $menu_full_name = master_array_start[3]
    elsif menu_key == 'array_main'
        body_text = master_array_main[0]
        body_choices = master_array_main[1]
        $current_menu = master_array_main[2]
        $menu_full_name = master_array_main[3]
    elsif menu_key == 'exit'
        really_exit()
    end
end

def get_list_contents(current_menu) # = the_menus_contents
    number_of_menus = 0
    loop_counter = 0
    number_of_menus = (the_menus_contents.length + 1) #to counter the start at 0
        until loop_counter == number_of_menus
            if_elsif_converter = '#{if}'    
            return keys_entered == loop_counter  #keys_entered is a original menu item
            loop_counter += 1
            return (if_elsif_converter keys_entered = loop_counter)       
            return (run_ssh_cmd(the_menus_contents [(loop_counter - 1)]))
            return (return_on_enter(current_menu))
        if_elsif_converter = '#{elsif}'
        end
    return (elsif keys_entered = (loop_counter + 1)) # Menu Return Button
    return menu_navigator(go_back_menu(current_menu)) # Need to make hash 'go_back_menu' that keys of 'current menu => previous menu'
    return (elsif keys_entered = (loop_counter + 2))
    return menu_navigator('exit')
end

def realy_exit()
    puts "Did you know that everytime this program connects to your server it saves it in multiple logs:"
    puts "Look in the log directory for the log index named: " + Rainbow("ssh_dashboard_master.log").blue.bright
    exit(true)
end

# Code to imput from menu: elseif $current_menu == 'dash' # this should now be the only line to elsif
#                          get_menu_contents($current_menu) 

# OLD CODE CONFIRM IF SAME:

# elsif $current_menu == 'dash' = LINE 21 (still the same)
#     if keys_entered == '1' = LINE 6
#         run_ssh_cmd("df") = LINE 10
#         return_on_enter($current_menu) = LINE 11
#     elsif keys_entered == '2' = LINE 12 should turn into a elsif and line 8 should increase to 2 for next loop
#         run_ssh_cmd("cat /etc/samba/smb-shares.conf") = AS ABOVE IF LOOP WORKS
#         return_after_connection = 'WAITING...' = AS ABOVE IF LOOP WORKS
#         return_on_enter($current_menu) = AS ABOVE IF LOOP WORKS
#     elsif keys_entered == '3' = LINE 14
#         menu_navigator('main') = LINE 15
#     elsif keys_entered == '4' = LINE 16
#         menu_navigator('exit') = LINE 17
#     end

# test_hash = { 1 => 'item 1', 2 => 'item 2', 3 => 'item 3', 4 => 'item 4'}

