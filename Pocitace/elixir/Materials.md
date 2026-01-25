### Books
- https://livebook.manning.com/book/elixir-in-action-third-edition/
- https://pragprog.com/titles/d-akelixir/elixir-patterns/
- https://pragprog.com/titles/jkelixir/advanced-functional-programming-with-elixir/
- https://www.packtpub.com/en-us/product/build-your-own-web-framework-in-elixir-9781801815901
- https://arxiv.org/pdf/2306.06391.pdf - The Design Principles of the Elixir Type System 
### Videos
- https://www.youtube.com/playlist?list=PLbV6TI03ZWYVQEC_Txq_cV0Uy_s16b0d3
	- elixir crash course
### Courses
- https://elixirschool.com/
- https://exercism.org/tracks/elixir
- https://app.codecrafters.io/tracks/elixir - paid
### Articles & blogs
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