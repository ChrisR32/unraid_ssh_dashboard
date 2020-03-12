def connection_manager
system("clear")
puts "-- UnRaid SSH Dashboard -- Connection Manager -- Version 0.1 alfa --" 
# needs to read network.ini and list results
# eg...
# 1) ADDRESS: 199.111.43.1    USER: root     PASSWORD: true
# 2) ADDRESS: 199.111.43.1    USER: root     PASSWORD: true
# 3)
need to get array total then start choices prompt with that number of options


!!!!! def connection(var)
 if EDIT print
    edit...
if NEW print
     new....
if DEL print
         del
all using same def
end
# choices = %w(ip1 ip2 ip3)
# prompt.enum_select("Edit Connection?", choices)# =>
# #
# # Edit Connection? (HAS DELETE INSIDE)
# #   1) Print Address
# #   2) Print Address
# #   3) Print Address
# #   Choose 1-3 [1]:
---------> goto edit_connection (where asked varriables, edit? --> keep/edit per key.   delele ---> deletes)
-------------------------> then goto net_tester if edited / back if delete
---------------------------------------> then main dash
# choices = %w(ip1 ip2 ip3)
# prompt.enum_select("Open Connection?", choices)# =>
# #
# # Open Connection?
# #   1) Print Address
# #   2) Print Address
# #   3) Print Address
# #   Choose 1-3 [1]:
-------> goto connection_test
-------------------> then to main dashboard

add network? goto network config
--------> net_tester
----------------> dash

back? goto welcome_menu

exit goto exit_manager