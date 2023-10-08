===== Capistrano =====
- builds on rake
- adds:
  - server, role
  - on roles(:web,:db) do
  - run_locally do
  - with(variable hash) do - sets environment variables
  - execute :any_command, "with args", :here, "and here"
  - within directory do
  - before :starting, :ensure_user (do)
  - after ...
  - upload!(file,destination)
  - ask(name,default) - adds user answer to options - can be obtained by
    fetch(name)
