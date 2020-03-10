def test_connection(command)
  Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|  
    $result = ssh.exec!command
  end
if $result.gsub(/[^0-9A-Za-z]/, '') == $user_name
    $connect_test_result = "Connection Succesful"
    puts "Status: Connection with UnRaid server Succesful"
else
    puts "Connection Failed, please check your settings..."
end
return_on_enter
end

# Confirms connection by checking the directory (pwd) that you log in as (users normally start in their home directory eg. Login in as root the default directory should be root/