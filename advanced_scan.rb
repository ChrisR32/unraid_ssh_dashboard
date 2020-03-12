1. Gets what its scanning eg: network, hard drive, other,all ....etc..
2. Gets the array full of what it can run with variable 1.
3. Lists them as check boxes, tick what you want to run.
4. Prompts for output name, then runs one by one, saving each as goes,


require "tty-prompt"



def advanced_scans(selection)
    system("clear")
    puts "-- UnRaid SSH Dashboard -- Advanced Scan Libary -- Version 0.1 alfa --" 
advanced_scans = TTY::Prompt.new
advanced_scans.select("Please select from the following...") do |menu|
    menu.default 1, 12
    menu.choice 'CPU'
    menu.choice 'Memory'
    menu.choice 'Virtual Memory'
    menu.choice 'Networking'
    menu.choice 'Hard drives'
    menu.choice 'Admin scan tools'
    menu.choice 'Version info'
    menu.choice 'Misc Hardware'
    menu.choice 'Sensors'
    menu.choice 'Live Info'
    menu.choice "Return to dashboard"
    menu.choice "Exit Program"
if advanced_scans == "Return to dashboard"
    dash_info.rb
elsif advanced_scans == "Exit Program"
    exit_manager.rb
else
    get_tool_list(advanced_scans)
end
end