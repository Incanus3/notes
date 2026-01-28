- FileUtils
* File.expand_path(path - possibly relative, may start with ~, starting-point = '.')

http://tech.natemurray.com/2007/03/ruby-shell-commands.html
- exec 'command' - replaces process by command, than exits
- system 'command' - runs command in subshell, returns true/false, sets $? to
  exit status (integer)
- `comand` - returns output of the command (in array of lines), sets $? to
  Process::Status object (user .to_i or .exitstatus)
- IO.popen(command,&block) - yields IO object bound to stdin and stdout of
  process
- stdin,stdout,stderr = Open3.popen3(command)
  http://www.ruby-doc.org/stdlib-2.1.1/libdoc/open3/rdoc/Open3.html