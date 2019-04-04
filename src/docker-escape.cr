require "http/client"
require "./checks/*"
require "./utils/*"
require "./breakouts/*"

puts %q{
8888888b.                 888                     
888   Y88b                888                     
888    888                888                     
888    888 .d88b.  .d8888b888  888 .d88b. 888d888 
888    888d88  88bd88P    888 .88Pd8P  Y8b888P   
888    888888  888888     888888K 88888888888     
888  .d88PY88..88PY88b.   888  88bY8b.    888     
8888888P    Y88P    Y8888P888  888  Y8888 888       
                                                  
                                                  
                                                  
8888888888                                         
888                                                
888                                                
8888888    d8888b  .d8888b 8888b. 88888b.  .d88b.  
888       88K     d88P         88b888  88bd8P  Y8b 
888        Y8888b.888     .d888888888  88888888888 
888            X88Y88b.   888  888888 d88PY8b.     
8888888888 88888P   Y8888P Y88888888888P    Y8888  
                                  888              
                                  888              
                                  888              
88888888888             888 
    888                 888 
    888                 888 
    888  .d88b.  .d88b. 888 
    888 d88  88bd88  88b888 
    888 888  888888  888888 
    888 Y88..88PY88..88P888 
    888   Y88P    Y88P  888}

lib LibC
  fun getuid : Int
end

def main
  user_namespace_enabled=false
  container=in_container?
  if ARGV.size>0 && ARGV[0].to_s =="escape"
    breakout()
  elsif ARGV.size>0
    puts "Usage"
  end
end


def usage 
  puts("Docker Escape Tool\nUsage:")
end

def breakout
  puts("\n================================================")
  puts("======= Start common breakout techniques =======")
  puts("================================================")

  if unix_socket_present?
    unix_socket_breakout
    exit()
  end
  if is_net_mode_host?
    puts("blah")
  end
end

def is_net_mode_host?
  net_mode_host=false
  interfaces = NetSample::NIC.ifnames
  interfaces.each do | interface |
    if interface.includes? "docker" 
      puts("We're sharing the host network stack. It's worth nmap scanning localhost. We'll check for docker ports on 3275/6 now")
      net_mode_host=true
    end
  end
  net_mode_host
end

main()