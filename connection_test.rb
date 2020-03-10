def ssh_test(command)
  Net::SSH.start($ip_address, $user_name, :password => $password) do |ssh|  
    $result = ssh.exec!command
  end
end

def test_connection() 
  if $result.gsub(/[^0-9A-Za-z]/, '') == $user_name
      $connect_test_result = "Connection Succesful"
      puts "Status: Connection with UnRaid server Succesful"
  else
      puts "Connection Failed, please check your settings..."
  end
  return_on_enter($current_menu)
end
# Confirms connection by checking the directory eg. if logged in as root: the default directory should be root/