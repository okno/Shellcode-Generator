#!/usr/bin/env ruby
# okno - Pawel Zorzan Urban - https://pawelzorzan.com

def generate_c_shellcode(filename)
  shellcode = "\""
  ctr = 1
  maxlen = 15
  begin
    File.open(filename, "rb") do |file|
      file.each_byte do |b|
        shellcode += "\\x#{b.to_s(16).rjust(2, '0')}" 
        if ctr == maxlen
          shellcode += "\" \n\""
          ctr = 0
        end
        ctr += 1
      end
    end
    shellcode += "\""
    shellcode
  rescue Errno::ENOENT
    puts "Error: Failed to read the input file."
    exit(1)
  end
end
def generate_cs_shellcode(filename)
  shellcode = ""
  ctr = 1
  maxlen = 15
  begin
    File.open(filename, "rb") do |file|
      file.each_byte do |b|
        shellcode += "0x#{b.to_s(16).rjust(2, '0')},"
        if ctr == maxlen
          shellcode += "\n"
          ctr = 0
        end
        ctr += 1
      end
    end
    shellcode
  rescue Errno::ENOENT
    puts "Error: Failed to read the input file."
    exit(1)
  end
end
if __FILE__ == $PROGRAM_NAME
  if ARGV.length < 2
    puts "Usage: #{$PROGRAM_NAME} file.bin c|cs\n"
    exit(0)
  end
  if ARGV[1] == "c"
    shellcode = generate_c_shellcode(ARGV[0])
    puts shellcode
  else
    shellcode = generate_cs_shellcode(ARGV[0])
    puts shellcode
  end
end
