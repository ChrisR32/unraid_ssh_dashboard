# Runs the ssh command
# Returns result to user
# Saves the returned information from server
# Creates or Adds to: 2 log files in the log directory:
#     1. Named after the command used, this contains:
#           - The command used
#           - The commands output
#           - The local server and client time
#           - The account used
#           - IP address used to access
#     2. A Master Log named 'ssh_dashboard_master.log'
#           - The account used
#           - Client time
#           - Command used
# Removes special characters from the command so when naming the log it's not a invalid filename

def run_ssh_cmd(command)
  local_time = Time.now.to_s
  log_file_name = "logs/ssh_dashboard_#{command.gsub(/[^0-9A-Za-z]/, '')}.log"
  Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|  
    $result = ssh.exec!command
    puts $result
    result_log = "-->> NEW ENTRY created by USER: #{$user_name} via GATEWAY: #{$ip_address} \n-->> SSH-Client executed the following COMMAND: #{command}   \n-->> Local server TIME: " + ssh.exec!("date\necho\n") + $result + "\n-->> END OF ENTRY at SSH-Client Time: #{local_time} \n\n"
    File.open log_file_name, 'a+' do |f|
      f.puts(result_log)
    end
  end        
  master_log = "AT: #{local_time} --> USER: #{$user_name} --> INIT_CMD: #{command} --> SEE_LOG: #{log_file_name}"
    File.open "logs/ssh_dashboard_master.log", 'a+' do |f|
      f.puts(master_log)
    end
end
