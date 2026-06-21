# Python packages and tools

## Indexes / catalogs

- https://github.com/vinta/awesome-python (last update 06/2026) - opinionated list of Python frameworks, libraries, tools, and resources.

## Standard library / functional tools

- https://docs.python.org/3/library/functional.html - Python standard-library documentation for functional programming tools.
  - `itertools` - functions creating iterators for efficient looping.
    - `count`, `cycle`, `repeat`
    - `accumulate`, `takewhile`, `dropwhile`, `groupby`
    - `product`, `permutations`, `combinations`
  - `functools` - higher-order functions and operations on callable objects.
    - `reduce`
  - `operator` - standard operators as functions; useful for mapping, reducing, filtering, etc.
- https://realpython.com/python-itertools/ - Real Python guide to `itertools` in Python 3.

## Development / debugging

- https://github.com/gruns/icecream (last update 04/2026) - nice debug prints; “never use `print()` to debug again”.
- https://birdseye.readthedocs.io/en/latest/ - graphical Python debugger.

## Testing

- https://expects.readthedocs.io/ - assertion library that should be able to replace `assert` for `unittest`, Mamba, etc.

## Django / Django REST Framework

- https://github.com/django-extensions/django-extensions (last update 05/2026) - collection of global custom management extensions for Django.
- https://www.django-rest-framework.org - Django REST Framework documentation.
- https://github.com/alanjds/drf-nested-routers (last update 01/2026) - nested routers for Django REST Framework, e.g. `/clients/:id/canteens`.
- https://github.com/AltSchool/dynamic-rest (last update 04/2026) - dynamic extensions for Django REST Framework.
  - Optional inclusion of related records in responses, either embedded or sideloaded.
  - Optional inclusion/exclusion of deferred fields.
  - Optional filtering, with powerful operators that can be chained across relationships.
  - Optional sorting.
- https://github.com/miki725/django-rest-framework-bulk (last update 09/2020) - bulk CRUD view mixins for Django REST Framework.
- https://github.com/Axiologue/DjangoRestMultipleModels (last update 07/2024) - views and mixins for serializing multiple models or querysets in Django REST Framework.
- http://github.com/chibisov/drf-extensions (last update 12/2025) - collection of custom extensions for Django REST Framework.
- https://wq.io/ - framework/toolkit for building field data collection apps and APIs.
- http://jpadilla.github.io/django-rest-framework-xml/ - XML support for Django REST Framework.
- https://github.com/vbabiy/djangorestframework-camel-case (last update 06/2026) - camelCase JSON support for Django REST Framework.
- https://github.com/carltongibson/django-filter (last update 05/2026) - generic filtering system for Django QuerySets based on user selections.
- https://github.com/maraujop/django-crispy-forms (last update 06/2026) - DRY Django form rendering helpers.

## Cryptography

- https://cryptography.io - Python cryptography package documentation.
- http://blog.brainattica.com/rsa-with-cryptography-python-library-2/ - article about RSA with the Python `cryptography` library.
- http://stackoverflow.com/questions/6345786/python-reading-a-pkcs12-certificate-with-pyopenssl-crypto - StackOverflow question about reading a PKCS12 certificate with pyOpenSSL crypto.
