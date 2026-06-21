# WiceGrid

Source-code walkthrough of WiceGrid internals, based on the `rails3` branch.

Project: https://github.com/leikind/wice_grid (last update 03/2026)

## GridViewHelper

- Defines the grid table.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L83 - instantiates `GridRenderer` and evaluates the block passed to the grid helper in its context.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L110 - generates HTML for the table.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L358 - iterates over renderer columns and calls `#render_filter` on each.

## GridRenderer

- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L296 - defines a column.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L371 - selects the column class.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L421 - may be further modified depending on `attribute`, `custom_filter`, and `filter_type` parameters.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L442 - instantiates the column class.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L451 - adds the column to a stored hash.

A column can be of type `Columns::ViewColumn` or another type returned by `Columns.get_view_column_processor`, defined in:

- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns.rb#L95 - `ViewColumn` definition; should be the superclass of all other column types.
- `render_filter` delegates to `render_filter_internal`, which is a stub in `ViewColumn`; subclasses must implement it.

- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns/column_integer.rb#L8 - `ViewColumnInteger#render_field_internal` calls `text_field_tag` helper with options defined here.
- The field doesn't appear to have any special class for JS hooks, but it has an ID returned by `ViewColumn#form_parameter_name_id_and_query`:
  - https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns.rb#L195 - should just replace `[]` in parameters.

## JavaScript

- https://github.com/leikind/wice_grid/blob/rails3/vendor/assets/javascripts/wice_grid_init.js.coffee#L196 - `wice_grid_init` binds filter controls (and Enter in filter fields) to `WiceGridProcessor.process()`.
- `WiceGridProcessor.process()` calls `buildUrlWithParams()`, which is based on `@baseRequestForFilter` — the second parameter of the constructor.
- `wice_grid_init` instantiates `WiceGridProcessor` with parameters from the `processor-initialize-arguments` attribute of `.wg-data` elements.
- https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L539 - `base_link` is taken from here.
