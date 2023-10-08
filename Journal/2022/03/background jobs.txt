=== limitace aktualni implementace ===

- nelze pouzivat periodu slozenou z vice jednotek, resp. pretekajici limit dane jednotky, napr. 1h30
  resp. 90min
- joby zacinaji vzdy v cely nasobek periody, takze i kdyz dam napr.
  Every { 30.minutes }.startingAt(LocalTime.of(9.45)), tak se spusti v 10.00, 10.30, atd.
- periody, ktere v souctu nedaji celou vyssi jednotku, nebudou mit konzistentni periodu, napr.
  Every { 25.minutes } se bude ve skutecnosti poustet v 0, 25, 50 a pak opet v 0
- nelze specifikovat "posledni den v mesici"
- presun jobu, pokud mesic nema dany den, se nechova uplne konzistentne, viz
  assertThat(
      Every.month.on { 31.st }.at { 9.oclock }.nextOccurrence,
      Is(LocalDateTime.of(2000, 1, 31, 9, 0)),
  )
  assertThat(
      Every.month.on { 31.st }.at { 9.oclock }.nextNextOccurrence,
      Is(LocalDateTime.of(2000, 2, 29, 9, 0)), // next month has less than 31 days
  )

  assertThat(
      Every.month.on { 31.st }.at { 9.oclock }.startingAt(februaryFirst).nextOccurrence,
      Is(LocalDateTime.of(2000, 3, 2, 9, 0)), // this month has less than 31 days
  )
  assertThat(
      Every.month.on { 31.st }.at { 9.oclock }.startingAt(februaryFirst).nextNextOccurrence,
      Is(LocalDateTime.of(2000, 3, 31, 9, 0)),
  )






Vlastní účet 228260140/0600
Účet příjemce 1011-7926201/0710
Název socialni pojisteni
Částka 3 720,00 CZK
Frekvence plateb Měsíčně
Datum první platby 26. 4. 2019
Datum příští platby 26. 3. 2022
Variabilní symbol 28676309
Konstantní symbol 938
