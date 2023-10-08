class TestSomething(PaymentTestHelpers):
  @pytest.fixture(autouse = True)
  def trivial_setup(self, test_canteen):
    self.items   = self.test_canteen.create_items()
    self.orders  = self.test_canteen.create_orders()
    self.payment = self.quick_pay(orders = self.orders) # vezme prvni payment medium?

    # vysledkem jsou self.items.(whiskey|banana|chocolate) a self.orders.(whiskey|banana|chocolate)
    # se statickymi nazvy ale nahodnym zbytkem:
    # - c_data, c_karty, apod. ze sekvenci
    # - price a quantity nahodne v rozumnem rozsahu
    # - vat_rate cykli pres existujici, musi existovat aspon jedna

  @pytest.fixture(autouse = True)
  def intermediate_setup(
    self,
    test_canteen,
    base_vat_rate,
    first_reduced_vat_rate,
    second_reduced_vat_rate,
    cash_payment_medium,
  ):
    self.items = self.test_canteen.create_items(
      whiskey__vat_rate   = base_vat_rate,
      banana__vat_rate    = first_reduced_vat_rate,
      chocolate__vat_rate = second_reduced_vat_rate,
    )

    self.orders = self.test_canteen.create_orders(
      whiskey__quantity   = 1,
      banana__quantity    = 3,
      chocolate__quantity = 5,
    )

    # pripadne obdobne s dicty

    self.payment = self.quick_pay(orders = self.orders, payment_medium = cash_payment_medium)

  @pytest.fixture(autouse = True)
  def advanced_setup(
    self,
    test_canteen,
    base_vat_rate,
    first_reduced_vat_rate,
    second_reduced_vat_rate,
    cash_payment_medium,
    card_payment_medium,
  ):
    self.whiskey = self.test_canteen.create_item_with_price(
      name     = 'Whiskey 2cl',
      price    = 100,
      vat_rate = base_vat_rate
      # poskytne defaulty na c_data, c_karty, jak bylo reseno vyse
    )
    self.chocolate = self.test_canteen.create_item_with_price(
      name     = 'Chocolate',
      price    = 50,
      vat_rate = first_reduced_vat_rate
    )
    # mohlo by byt
    self.whiskey = self.test_canteen.create_whiskey(
      price    = 100,
      vat_rate = base_vat_rate
    )
    self.chocolate = self.test_canteen.create_chocolate(
      price    = 50,
      vat_rate = first_reduced_vat_rate
    )
    # ale je to takova vyhoda?
    # pokud nebude, bude samozrejme create_items volat primo create_item_with_price

    self.whiskey_order   = self.test_canteen.create_order(self.whiskey,   quantity = 1)
    self.chocolate_order = self.test_canteen.create_order(self.chocolate, quantity = 5)

    self.payment1 = self.quick_pay(
      orders = [self.whiskey_order], payment_medium = cash_payment_medium
    )
    self.payment2 = self.slow_pay(
      orders = [self.chocolate_order], payment_medium = card_payment_medium
    )

# create_(items|orders) metody by mohly byt primo na TestCanteen
# 1) dava to smysl v tom, ze create_item_with_price a create_order metody na Canteen a TestCanteen
#    je jen obohacuje o defaulty, tohle je jen o krok dal, ze to Canteenu celkove obohacuje o defaultni
#    itemy a ordery
# 2) pokud je na test_canteen, lze jeste lepe predpokladat, ze existuje default_tax_rate
# - dokonce bych v tuto chvili zvlazoval, jestli pri nespecifikaci tax_rate skutecne nedavat vzdy
#   default, protoze tam, kde nas zajima, tak stejne budeme specifikovat a tam kde ne, tak je to
#   nejspis uplne jedno a je to prirozene, kdyz uz TestCanteen default_tax_rate definuje
# 3) helpery se muzou starat jen o setupy potrebne pro konkretni operace, napr. v pripade
#    ClosureTestHelpers nastaveni KasTitles, ale na tyto obecne setupy, ktere jsou potreba skoro vsude,
#    nebudou potreba helpery
