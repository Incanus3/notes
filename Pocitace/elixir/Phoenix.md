### Materials
#### Books
- https://pragprog.com/titles/phoenix14/programming-phoenix-1-4/
	- bohuzel jen pro verzi 1.4 - zastarale
- https://pragprog.com/titles/liveview/programming-phoenix-liveview/
- https://pragprog.com/titles/ldash/ash-framework/
#### Docs
- https://hexdocs.pm/phoenix/overview.html
- https://hexdocs.pm/phoenix_live_view/welcome.html
#### Articles
- https://dev.to/lubien/the-lazy-programmers-intro-to-liveview-chapter-1-1487
- https://www.viget.com/articles/how-to-redirect-from-the-phoenix-router/
- https://fly.io/phoenix-files/dynamic-forms-with-streams/
- https://binarynoggin.com/blog/dynamic-form-inputs-in-elixir-liveview/
#### Videos
- https://www.youtube.com/playlist?list=PLbV6TI03ZWYXKCJePfD8G34hyWdW_WLFk
	- Phoenix crash course
- https://www.youtube.com/@CodeAndStuff/playlists
- https://www.youtube.com/watch?v=rvwShn-c-_M&ab_channel=GoodToHear
	- Pragmatic Forms with Phoenix Live View
### Libraries
- https://hexdocs.pm/ecto/Ecto.html
- https://ash-hq.org
- https://surface-ui.org
- https://daisyui.com/
	- https://www.moendigital.com/blog/how-add-daisyui-elixir-phoenix-project-and-why-you-should/
### Interesting projects for code exploration
- https://github.com/livebook-dev/livebook
- https://github.com/chrismccord/todo_trek
- https://github.com/fly-apps/live_beats
	- https://fly.io/blog/livebeats/
- https://github.com/rauversion/rauversion-phx
- https://github.com/BanchanArt/banchan
### Starting new project
```
mix archive.install hex phx_new 1.8.0
mix help phx.new
mix phx.new gitlab_graphs
cd gitlab_graphs/
cp ../elizar/run_postgres.sh .
vim run_postgres.sh # edit name
./run_postgres.sh 
mix phx.gen.auth Accounts User users --hashing-lib argon2
mix phx.gen.live Test Resource resources name:string age:integer
# add printed routes to router.ex
mix setup
mix test
iex -S mix phx.server
```