== 16.7. ==

- 9.30-12, 12.30-16 - 6h
- rozbehnuti multi-ea v kb - 2h


== essentials III ==
- dancing queen
- frozen - let it go
- alicia keys - girl on fire


a -> b, c
d -> e, f

- should be

(a -> b, d -> e), (a -> c, d -> e), (a -> b, d -> f), (a -> c , d -> f)

- if we do sth like map.values.product, we'l get [(b, e), (b, f), (c, e), (c, f)], but we need to map
  the values back to the keys
- if key order is stable, the value ordering in each tuple should correspond to the key ordering


- 10 + 45 + 15 + 20 = 90
- 15 + 65 + 20 + 30 = 130

== refactor inputu ==

TODO:
- zbavit se duplicit v coercich - typicky se cast resi v coerceValue a cast primo v implementaci slotu
- nejspis nastavovat dirty jinde
