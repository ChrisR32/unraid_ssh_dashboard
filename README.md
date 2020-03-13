H1 UNRAID SSH DASHBOARD

H3 REQUIREMENTS
I'm not aware of any hardware dependancies but if you come across any please let me know via a bug repot.

It does require the following Ruby Gems:

H4 rainbow GEM
install it via rubygems by typing:   gem install rainbow

H4 terminal-basic-menu GEM
Install it via rubygems by typing:   gem install terminal-basic-menu

H4 net:ssh GEM
Install it via rubygems by typing:   gem install net/ssh

H2 Sources
H3  Source Gems that I used for the progam
https://github.com/sickill/rainbow
https://github.com/dav-armour/terminal-basic-menu/blob/master/lib/terminal-basic-menu.rb
https://www.rubydoc.info/github/net-ssh/net-ssh/Net/SSH/Packet

H3 Source websites that I used to get answers when it would all go wrong
https://net-ssh.github.io/ssh/v1/chapter-4.html
https://wiki.unraid.net/Console
https://wiki.unraid.net/Terminal_Access
https://stackoverflow.com/questions/21446369/deleting-all-special-characters-from-a-string-ruby/21446469
https//www.unraid.com
https://medium.com/@ryannovas/ruby-file-and-directory-cheatsheet-16bd36315d46


H3 What does the application do?
- The main thing it does is SSH into Unraid Server which then gives you these features:
    - Allows you to monitor server though a interative menu system, making it more user friendly to people new to command line. 
    - Has a vast majority of tools to diagnose problems,making a problem that seamed impossible to work out while staring at the blinking Command Prompt screen, frantacly searching Google, is now a few menu options away. 
    It currently has saved commands to run scans for the:
        - CPU
        - Memory + Virtual Memory
        - Inbuilt computer sensors
        - Network connections
        - Hard Drives
        - Admin scans - eg. last entrys of systems logs and sercurity permissions
        - Plus a whole bunch of random ones, eg. tells you your linux and openssl version
    - Then there is the Dashboard which is like an every day type funtion its what I would concider the home page as it just scans and  gives you information on how its going:
        - Shows you what docker services are running
        - You hard drive shares
        - Current CPU % status (what cores are at what percent) 
        - Ram % status
        - Hard Drive remaining status
        - and the general information like: Server Name, Server Date, Linux Version, Unraid Versiom
    - Array Functions which walks you though how to stop the array for reboot the correct way so that the next time you turn on your server it wants a parity check which can take days 
    - Then theres things it does in the background that the user mightn't even be aware of until they need it, the main one is the logs: So each time a scan is done it makes (or adds too) a log file relating to just that particular command. It then adds to another log that just keeps the basics, eg. what command was run but not the results, its more like a index file that you use to find the answer file.
    - The menu system handles incorrect input by reprompting you the expected results by using information about current menu and that menu length. Sends the wrong responce to the bad choice method. A example from the settings menu follows:
            
            Please make a selection: 7
            I didn't recognise that selection, please select a number between 1 and 6
            Press the ENTER key to return to Setup Connection Menu and try again . . . .

            IT PRINTS WHAT YOU ENTERED, TELLS YOU IT DIDN'T RECOGNISE THIS, TELLS YOU THE AVAILIABLE OPTIONS AND THEN ASKS YOU TO PRESS ENTER THE RETURN TO THE MENU THAT YOU WERE IN. ANOTHER EXAMPLE FROM THE HARD DRIVE TOOL MENU:

            Please make a selection: 165
            I didn't recognise that selection, please select a number between 1 and 15
            Press the ENTER key to return to Hard Drive Tools Menu and try again . . . .

    - Hard drive scans prints out your installed drives, highlighting the avaliable options in pink and walks you though how to pick which drive.
    - the $current_menu value is pretty much what keeps the while loop on line 749 continuing as long as its not set to exit
    - keys_entered_decrypter method sends the correct entered keys to the correct menu. Then the menu runs the command that belongs to that key.

My hopes are that i'll become something that gets more people into open source, there is a bit of a jumping off point for people when it comes to running linux. I mean it's gotten alot better then it used tp be I remember I had to try and compile a linux kernal to get it to work back in 1999 and gave up, and even the user friendly options back then like Mandrake made you feal a little left behind in some areas and it wasn't long till you "had" to reinstall windows for this program or that program. Now days but it alot different, esecially with the things an open source solution can produce, making it cheaper and better than the "Usual" go-to. But then there are people who had never used linux before finding themselves with a tool running it, for example media servers and NAS servers.

So my program is for those people, the linux n00bs: Yes my program can run a whole buch of diagnostics in its tools section when things go wrong, but it also can give someone the piece of mind that its all okay (eg. you've got plenty of hard drive space, running 2 video streams doesn't stress the cpu) all without going into the scary world of the command line (apart from running my program, which is ironic, but if you need help with that see bellow in installation). Ultimatly the end goal is to give a sort of half way point between the GUI and the command live, some every day type examples are bellow:

- So when their away for example not be able to log into their NextCloud server and wonder is it me or is the docker that runs my NextCloud service down? They could ssh in and within a few clicks have a screen showing them stats on their dockers.
- People who don't remember commands that well, eg know they need to work out their network addapter name, 'et0'  for example  but just cant work it out and its starting to get on their nerves and everything they try on the internet seams to be opening up new problems and again with unraid ssh dashboard, they would pick the button to see network devices and bam there it is.

UnRaid SSH Dashboards goal is to ease some people into getting use to the Linux console.

KNOWN PROBLEMS:
- It bugs out harder than anything ive ever scene it bloody epic at that, possible pivot to virus
- But really the connection test seams to work okay on my local network, but though the vpn can be dodgee and hard Crash. I need to work out how to read failed results from the run_ssh_cmd as a failed result does crash my app when outside my network. Its strange that at home is just prints the error from the server then enter_to_return, so I never really bothered with fixing connection checking as I thought worse case it would just show the error which tells you everything anyhow.

- It's also important to note that not all commands will run on your setup, so if something doesn't run check the command in person to know for sure. An example of this is theres a test that checks for AMD virtualition capacity - this will fail on a intel machine.

- Please send bug reports so I can fix them and add to the list ! :)

To run Debug Mode enter: (Only helps you if it didn't hard crash)
    - IDKFA -- which gives you information on the main values and their settings and run 
    - IDCLIP -- to jump to other menus if you get stuck (though this sometimes creates a bug and hard crashes the next menu)

HOW TO USE:
THIS IS MENU DRIVEN 99% OF THE TIME YOUR TYPYING A NUMBER THEN ENTER TO RUN THIS OR GOTO THIS MENU.
SOME EXAMPLES ARE BELLOW, IT WOULD BE ALOT OF REPEATING TO TYPE OUT EVERY MENU:

Start Menu:
    - 1 = Continue - 1 THEN ENTER
    - 2 = Exit - 2 THEN ENTER

Settings Menu
    - 1 = ENTER IP ADDRESS - 1 THEN ENTER --> PROMPT --> TYPE IP THEN ENTER --> UPDATES THE MENU TO THE IP ADDRESS SO USER KNOWS IT WORKED
    - 2 = ENTER USER NAME - 2 THEN ENTER --> PROMPT --> TYPE USER THEN ENTER --> UPDATES THE MENU TO THE IP ADDRESS SO USER KNOWS IT WORKED
    - 3 = ENTER PASSWORD - 3 THEN ENTER --> PROMPT --> TYPE PASSWORD THEN ENTER --> UPDATES THE MENU TO THE 'ENTERED' SO USER KNOWS IT WORKED BUT DOESN'T DISPLAY THE PASSWORD
    - 4 = TEST CONNECTION - 4 THEN ENTER
    - 5 = MAIN MENU - 5 THEN ENTER
    - 6 = EXIT 6 THEN ENTER







 
R8	Develop a diagram which describes the control flow of your application. Your diagram must:
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.	 
R9	Develop an implementation plan which:
- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item

Utilise a suitable project management platform to track this implementation plan

> Your checklists for each feature should have at least 5 items.	 
R10	Design help documentation which includes a set of instructions which accurately describe how to use and install the application. 

You must include:
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements