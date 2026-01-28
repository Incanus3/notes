== GridViewHelper ==
- definuje tabulku
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L83
- instanciuje GridRenderer a nasledne v jeho kontextu vyhodnoti blok, se kterym volame grid helper
  ve view
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L110
- generuje html pro tabulku
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L217
- iteruje pres columny rendereru a vola na ne #render_filter
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/helpers/wice_grid_view_helpers.rb#L358

== GridRenderer ==
- definuje sloupec
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L296
- vyber tridy sloupce
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L371
- muze byt dale zmeneno v zavislosti na parametrech attribute, custom_filter a filter_type
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L421
- instanciuje tridu sloupce
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L442
- prida sloupec do ulozene hashe
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L451

- sloupec tedy muze byt typu Columns::ViewColumn, nebo jiny vraceny volanim
  Columns.get_view_column_processor, tedy definovany v
https://github.com/leikind/wice_grid/tree/436f32b5ef62b3d8a8b526a84daa16f147925090/lib/wice/columns

- ViewColumn by mel byt superclass vsech ostatnich
- definice ViewColumn
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns.rb#L95
- definice render_filter deleguje na render_filter_internal, ktery je u ViewColumn stub, subclassy
  musi implementovat

- ViewColumnInteger#render_field_internal vola text_field_tag helper s optionami definovanymi zde
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns/column_integer.rb#L8
- field se nezda mit zadnou specialni class, na kterou by byly poveseny js, ma ale id vracene
  ViewColumn#form_parameter_name_id_and_query - definovano zde
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/columns.rb#L195, coz by melo pouze
nahradit [] v parametrech

== javascripty ==
- wice_grid_init navaze filtrovaci cudly (a enter ve filtrovacich fieldech) na
  WiceGridProcessor.process()
https://github.com/leikind/wice_grid/blob/rails3/vendor/assets/javascripts/wice_grid_init.js.coffee#L196
- WiceGridProcessor.process() vola buildUrlWithParams(), ktera vychazi z @baseRequestForFilter, coz je
  druhy parametr konstruktoru
- wice_grid_init instanciuje WiceGridProcessor parametry z atributu processor-initialize-arguments
  elementu .wg-data

- atributy se definuji zde
https://github.com/leikind/wice_grid/blob/8db9abc6ab26a2e906b34939469ed04fa4fd17c5/lib/wice/helpers/wice_grid_view_helpers.rb#L476
- base_link se bere odsud
https://github.com/leikind/wice_grid/blob/rails3/lib/wice/grid_renderer.rb#L539