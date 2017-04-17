#!/usr/bin/ruby

require 'socket'
require 'optparse'
require 'net/http'

def getLANAddress
  Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
end

def getWANAddress
  Net::HTTP.get URI 'http://www.icanhazip.com'
end

def printHelp
  puts 'Usage: iputil [options]'
  puts '    -l    Display the first LAN Address'
  puts '    -w    Display the WAN Address (HTTP)'
  puts '    -h    Display this message'
end

options = {}
printHelp if ARGV.length == 0
OptionParser.new do |opts|
  opts.banner = 'Usage: iputil [options]'

  opts.on('-v', "--[no-]verbose", 'Run verbosely') do |v|
    options[:verbose] = v
  end

  opts.on('-l', '--lan', 'Display LAN Address') do |l|
    options[:lan] = l
  end

  opts.on('-w', '--wan', 'Display WAN Address') do |w|
    options[:wan] = w
  end

  opts.on('-h', '--help', 'Display help') do
    printHelp
  end

end.parse!

if options[:lan]
  if options[:verbose]
    printf 'LAN: '
  end
  puts getLANAddress
end

if options[:wan]
  if options[:verbose]
    printf 'WAN: '
  end
  puts getWANAddress
end
if options[:secure]
  if options[:verbose]
    printf 'WAN (HTTPS): '
  end
  puts getWANAddressSecure
end


