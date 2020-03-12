begin
    require 'termios'
  rescue LoadError
  end
  
  def stdin_buffer( enable )
    return unless defined?( Termios )
    attr = Termios::getattr( $stdin )
    if enable
      attr.c_lflag |= Termios::ICANON | Termios::ECHO
    else
      attr.c_lflag &= ~(Termios::ICANON|Termios::ECHO)
    end
    Termios::setattr( $stdin, Termios::TCSANOW, attr )
  end
  
  host = ARGV.shift "[root@]192.168.15.3"
  if host =~ /@/
    user, host = host.match( /(.*?)@(.*)/ )[1,2]
  else
    user = ENV['root'] || ENV['USER_NAME']
  end
  
  Net::SSH.start( host, user ) do |session|
  
   begin
      stdin_buffer false
  
      shell = session.shell.open( :pty => true )
  
      loop do
        break unless shell.open?
        if IO.select([$stdin],nil,nil,0.01)
          data = $stdin.sysread(1)
          shell.send_data data
        end
  
        $stdout.print shell.stdout while shell.stdout?
        $stdout.flush
      end
    ensure
      stdin_buffer true
    end
  
  end
  