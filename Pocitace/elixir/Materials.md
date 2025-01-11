### Books
- Elixir in Action - https://livebook.manning.com/book/elixir-in-action-third-edition/
- Programming Phoenix - bohuzel jen pro verzi 1.4 - zastarale
- Programming Phoenix LiveView
- Build your own web framework in Elixir
- The Design Principles of the Elixir Type System - https://arxiv.org/pdf/2306.06391.pdf
### Web
- https://elixirschool.com/
- https://exercism.org/tracks/elixir
- https://app.codecrafters.io/tracks/elixir - paid
- https://www.theerlangelist.com - Saša Jurić's blog, including great series on macros
- https://shyr.io/blog/composable-custom-guards-elixir
- https://aaronrenner.io/2023/07/22/elixir-adapter-pattern.html
- [Building a BitTorrent client in Elixir](http://kochika.me/posts/torrent/)
### LiveBooks
- https://notes.club
- https://github.com/DockYard-Academy/curriculum
## Libraries and modules
- https://hexdocs.pm/elixir/main/enum-cheat.html
- https://hexdocs.pm/gen_stage/GenStage.html - Stages are data-exchange steps that send and/or receive data from other stages
- https://hexdocs.pm/flow/Flow.html - computational flows with stages
	- [`Flow`](https://hexdocs.pm/flow/Flow.html#content) allows developers to express computations on collections, similar to the [`Enum`](https://hexdocs.pm/elixir/Enum.html) and [`Stream`](https://hexdocs.pm/elixir/Stream.html) modules, although computations will be executed in parallel using multiple [`GenStage`](https://hexdocs.pm/gen_stage/1.2.1/GenStage.html)s.
- https://hex.pm/orgs/dashbit - Jose's company, many interesting libs including broadway, flow and the nimble toolkit
- https://hexdocs.pm/explorer/Explorer.html - Explorer brings series (one-dimensional) and dataframes (two-dimensional) for fast data exploration to Elixir
- https://hexdocs.pm/ex_unit/main/ExUnit.html
- https://github.com/lpil/mix-test.watch
## Phoenix
- https://hexdocs.pm/phoenix/overview.html
- https://hexdocs.pm/phoenix_live_view/welcome.html
- https://hexdocs.pm/ecto/Ecto.html
- https://ash-hq.org
- https://surface-ui.org
- https://daisyui.com/
	- https://www.moendigital.com/blog/how-add-daisyui-elixir-phoenix-project-and-why-you-should/
- https://dev.to/lubien/the-lazy-programmers-intro-to-liveview-chapter-1-1487
- https://www.viget.com/articles/how-to-redirect-from-the-phoenix-router/
- https://fly.io/phoenix-files/dynamic-forms-with-streams/
- https://binarynoggin.com/blog/dynamic-form-inputs-in-elixir-liveview/
- https://www.youtube.com/watch?v=rvwShn-c-_M&ab_channel=GoodToHear - Pragmatic Forms with Phoenix Live View
### Interesting projects for code exploration
- https://github.com/livebook-dev/livebook
- https://github.com/chrismccord/todo_trek
- https://github.com/fly-apps/live_beats
	- https://fly.io/blog/livebeats/
- https://github.com/rauversion/rauversion-phx
- https://github.com/BanchanArt/banchan