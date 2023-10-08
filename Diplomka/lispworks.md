* loading by quicklisp/asdf behaves strangely with binding macros (e.g. with-saved-slots)
  * it complains about variables used in the bindings, as if they were evaluated - as if the macro isn't expanded
  [] print loading of file, ensure the macro is defined
  [] use (load (compile-file *)) in load-manual
* eval-when
  * when you want helper functions for macros (they need to be defined during compile time)
  * when your macros expand into definitions, that are used later on - e.g. def-test-method, the expansion should include eval-when
