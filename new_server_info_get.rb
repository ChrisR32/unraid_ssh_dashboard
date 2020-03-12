def get_new_ip()
    print "Please enter your UnRaid servers IP address: "
    $ip_address = gets.chomp
    menu_navigator("setup_new")
end
    
def get_new_user()
    print "Please enter your login name: "
    $user_name = gets.chomp
    menu_navigator("setup_new")
end
    
def get_new_pass()
    print "Please enter your password: "
    $password = gets.chomp
    $safe_word = "ENTERED"
    menu_navigator("setup_new")
end