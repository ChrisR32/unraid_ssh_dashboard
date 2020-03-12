
require_relative 'main'


def ssh_menu(keys_entered)
    if keys_entered == '1'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '2'
        puts 'NOT SETUP YET PRESSED 1'
    elsif keys_entered == '3'
        menu_navigator('main')
    elsif keys_entered == '4'
        menu_navigator('exit')
    end  
end