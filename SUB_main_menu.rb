
require_relative 'main'


def main_menu(keys_entered)
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
    end
end