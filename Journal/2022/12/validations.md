=== prekladani chyb pri vytvareni entit ===

- DataStructureBase.set() haze SlotNotFound, SlotIsNotMutable nebo InvalidSlotValue
- .setAll() pouze vola .set() v cyklu
- RegistryBase.new() preklada SlotNotFound a InvalidSlotValue (prevdepodobne by mel prekladat i
  SlotIsNotMutable) na CannotCreateArtifact
- RegistryBase.create() navic preklada CannotSaveEntity na CannotCreateArtifact
- RegistryDispatcherImpl.createEntity() odchytava vsechny chyby a obali je do Result.failure()
- RegistryController.createEntity() chybu zase vybali a podle typu vytvari CreateErrorsDto

- InvalidSlotValue v podstate odpovida validacnim chybam, resp. je nadmnozinou ValidationError -
  muze jeste dojit k chybe pri typove konverzi, tu bych ale klidne od validacni nerozlisoval
- DataStructureBase.setAll() by tedy nejspis mela pochytat vsechny InvalidSlotValue, vytvorit z
  nich kompozitni ValidationErrors a ten vyhodit
- otazkou je, jak by se mely reprezentovat nevalidacni chyby specificke pro slot - SlotNotFound,
  SlotIsNotMutable, zatim bych asi proste pri prvni takove vyjimce nechal probublat a vratil jako
  global error

=== faktura ===

- graphs - 30h
- tree input - 30h
- ebean upgrade + fix problems - 30h
- manual qstore refresh - 20h
- DT params - 18h
= 100h
- ma byt 128
