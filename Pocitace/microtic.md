=== MIKROTIK ===

- v interfaces-ethernet nastavit jmena portu, rychlost a pokud maji byt porty spojeny/switchovany (master port)
- v Bridge-Bridge vyvorime bridge pro kazdou vnitrnich sit (treba LAN a DMZ), to nam da pozdeji svobodu sdruzovat do nich ethernetove i wireless interfaces
- v Bridge-Ports zaradime do jednotlivych bridges interfaces, ktere chceme
- v IP-addresses nadefinovat adresy jednotlivych siti vcetne masky ve tvaru s lomitkem
- v IP-pool nadefinovat rozsahy adres, ktere bude pridelovat DHCP server jednotlivym sitim
- v IP-DHCP server-Networks nastavit adresy siti a gateways a DNS tak, jak je v ip-addresses
- Tamtez v DHCP nastavit pro jednotlive site dhcp servery - jmeno, pool a leasetime

pokud ISP poskytuje parametry prostrednictvim DHCP,
--- v IP-DHCP Client nastavit klienta
jinak
--- v IP-Routes pridat pro 0.0.0.0/0 adresu gatewaye poskytovatele
--- v IP-DNS nastavit staticke adresy dns serveru poskytovatele
--- v IP-Addresses nastavit statickou adresu na interface WAN

-pridat uzivatele pro nastavovani mikrotiku v System-Users
-V System-NTP Client nastavit mode=unicast, adresy treba 195.113.144.201, 194.137.39.68, 213.180.32.5, enablovat. v System-Clock nastavit Timezone=Europa/Praha

==============    VPN    ==============
- v PPP-profiles vyrobit profil default-encrypted, v nem nastavit UseEncryption=required
- v PPP pridat interface, v buttonu PPTPserver enablovat,
- v zalozce Secrets nastavit uzivatele: service=pptp profile default-encryption, local a remote address

==============    WiFi    ==============
- v Wireless-Security profiles nastavit existujici profil default: Mode = dynamic keys, Autentication jen WPA2, Cipher jen AES s silenym dlouhym heslem
    a vytvorit profil WPA2 se stejnym nastavenim, ale heslem, ktere bude pouzito

- v Wireless-Interfaces kliknout na wlan1, button Advance mode a v zalozce Wireless nastavit mode APbridge, pasmo a kanal, dlouhe nesmyslne SSID, protokol 802.11, security profile default, country Czech, checkboxy Default Authenticate i Default Forward = No a Hide SSID = Yes. v zalozce Advanced nastavit max station count =1,
- v Wireless-Interfaces pridat virtualni AP s rozumnym SSID, security profile WPA2, nastavit MaxStationCount podle potreby a checkboxy Default Authenticate=Yes (jinak se neprihlasi nikdo mimo access-list) i Default Forward = Yes (jinak se bezdratovi klidenti navzajem neuvidi) a Hide SSID = Yes
- virtualAP priradit do prislusneho bridge, zatimco wlan1 nikam prirazen byt nesmi. virtualnich AP muze byt vice a k nim security profiles.


-------------- poznamky  ----------------
protoze ve filter rules-input je pravidlo vsechno zevnitr definovano jako InputInterface#WAN, nemusi byt v AddressListu Spravci ani vnitrni adresy, ani adresy z VPN
test input-icmp poresit skokem do retezce icmp, jak to mam udelany doma
pri dst-nat na stejny port se v action nemusi cislo portu opakovat
dst_nat delat na InputInterface, ne na adresy, stejne tak srcnat na Out.Interface
kdyz firewalove chainy zacinaji sekvenci established, related, invalid, ta dalsi pravidla se uplatni jen pri navazovani nejake komunikace, protoze jeji pokracovani uz spadne do toho established
