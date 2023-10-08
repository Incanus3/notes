===== Rake =====
- invocation - https://github.com/jimweirich/rake/blob/master/doc/command_line_usage.rdoc
- rakefiles - https://github.com/jimweirich/rake/blob/master/doc/rakefile.rdoc

=== Rakefiles ===
- Rakefile is search in current dir, than in parents
- when invoking rake task in subdir, it's still run from the dir with Rakefile
- rakelib directory can be placed along Rakefile, tasks can be defined in files
  with .rake extension
  - rails projects may place .rake files in lib/tasks
- rake DSL includes FileUtils (so these can be called without prefix) and adds
  sh and ruby methods

```
task :default => [:test]

desc "Create a distribution package" # shows up in rake -T output
task :test do
  ruby "test/unittest.rb"
end
```

A task may be specified more than once. Each specification adds its prerequisites
and actions to the existing definition. This allows one part of a rakefile to
specify the actions and a different rakefile (perhaps separately generated) to
specify the dependencies.

== File tasks ==
file "prog" => ["a.o", "b.o"] do |t|
  sh "cc -o #{t.name} #{t.prerequisites.join(' ')}"
end

== Directory tasks ==
```
directory "testdata/examples/doc"
```
- creates file file task, that create directory

== Parallel prerequisities ==
```
multitask :copy_files => [:copy_src, :copy_doc, :copy_bin] do
  puts "All Copies Complete"
end
```
- prerequisities are run in parallel

== Tasks with parameters ==
```
task :name, [:first_name, :last_name] do |t, args|
  args.with_defaults(:first_name => "John", :last_name => "Dough") # optional
  puts "First name is #{args.first_name}"
  puts "Last  name is #{args.last_name}"
end
```
- call with rake "name[Jakub,Kalab]"

task :name, [:first_name, :last_name] => [:pre_name] do |t, args|
  puts "First name is #{args.first_name}"
  puts "Last  name is #{args.last_name}"
end
- both parameters and prerequisities

```
task :email, [:message] do |t, args|
  mail = Mail.new(args.message)
  recipients = args.extras
  recipients.each do |target|
    mail.send_to(target)
  end
end
```
- variable number of arguments
  - args.extras returns arguments that weren't matched to list
  - args.to_a returns all arguments

== Rules ==
```
rule '.o' => ['.c'] do |t|
  sh "cc #{t.source} -c -o #{t.name}"
end
```

== Namespaces ==
```
namespace "main" do
  task :build do
    # Build the main program
  end
end

namespace "samples" do
  task :build do
    # Build the sample programs
  end
end

task :build => ["main:build", "samples:build"]
```
- invoke using rake main:build
- can't be used with file/directory tasks

```
task :run

namespace "one" do
  task :run

  namespace "two" do
    task :run

    # :run            => "one:two:run"
    # "two:run"       => "one:two:run"
    # "one:two:run"   => "one:two:run"
    # "one:run"       => "one:run"
    # "^run"          => "one:run"
    # "^^run"         => "rake:run" (the top level task)
    # "rake:run"      => "rake:run" (the top level task)
  end

  # :run       => "one:run"
  # "two:run"  => "one:two:run"
  # "^run"     => "rake:run"
end
```
