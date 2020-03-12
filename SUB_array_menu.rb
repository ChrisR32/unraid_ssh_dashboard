
# require_relative 'main'


def array_menu(keys_entered)
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
    end        
end