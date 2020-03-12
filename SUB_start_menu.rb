
require_relative 'main'


def start_menu(keys_entered)
    if keys_entered == "1"
        menu_navigator("setup")
        elsif keys_entered == "2"
        menu_navigator("exit")
    end    
end