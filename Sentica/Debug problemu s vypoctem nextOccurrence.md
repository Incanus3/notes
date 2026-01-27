- mam nejaky startAt, napr. 7.1. 12:00
- mam nejakou periodu, napr. 7 days
- `truncateUnit` = `DAYS` (vsechny mensi jednotky jsou v periode nulovy)
- `unitAmount` = 7
- `truncated` = `7.1 0:00` - cas se orizne

- when spadne do DAYS vetve
- withDayOfMonth() se zavola s `7 - 7 % 7`  = 0 a mame problem
	- divny ovsem je, ze se to doted nedelo