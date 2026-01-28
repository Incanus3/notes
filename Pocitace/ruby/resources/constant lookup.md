http://cirw.in/blog/constant-lookup
'''
modules = Module.nesting + (Module.nesting.first || Object).ancestors
modules += Object.ancestors if Module.nesting.first.class == Module
found = nil
modules.detect do |mod|
  found = mod.const_get(#{name.inspect}, false) rescue nil
end
found or const_missing(#{name.inspect})
'''

http://valve.github.io/blog/2013/10/26/constant-resolution-in-ruby/
