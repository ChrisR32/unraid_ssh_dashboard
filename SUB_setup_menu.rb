
require_relative 'main'


def setup_menu(keys_entered)
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
    end
end