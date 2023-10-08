h1. Autentifikace

h2. Autentifikace dotazu

* dotazy, ktere vyzaduji autentifikaci, musi zahrnovat header '<code>Authorization</code>' ve formatu '</code>Token <token></code>', tedy napr '<code>Authorization: Token b883c0d9e52a41eac53f280f4adc6de716661899</code>'

h2. Obecne routy

h3. ziskani tokenu pro autentifikaci naslednych dotazu

<pre>POST /auth/get_token</pre>

* parametry v tele - username, password
* odpoved:

<pre><code class="json">
{
    "token": "b883c0d9e52a41eac53f280f4adc6de716661899",
    "user": {
        "date_joined": "2017-09-04T16:35:42.699384Z",
        "email": "admin@test.cz",
        "first_name": "",
        "id": 1,
        "is_active": true,
        "is_staff": false,
        "is_superuser": true,
        "last_login": null,
        "last_name": "",
        "username": "admin"
    }
}
</code></pre>

h3. registrace uzivatele

<pre>POST /auth/register</pre>

* query parametr - redirect (kam ma presmerovavat aktivacni odkaz v mailu)
* parametry v tele - email, username nebo use_email_as_username, password, first_name, last_name
* odpoved:

<pre><code class="json">
{
    "user": {
        "date_joined": "2017-09-05T13:40:44.613868Z",
        "email": "test@test.cz",
        "first_name": "",
        "id": 4,
        "is_active": false,
        "is_staff": false,
        "is_superuser": false,
        "last_login": null,
        "last_name": "",
        "username": "test"
    }
}
</code></pre>

h3. zadost o znovuzaslani aktivacniho emailu

<pre>POST /auth/resend_activation_email</pre>

* query parametry - email, redirect
* odpoved: <code>204 No Content</code>

h3. aktivace uzivatele

<pre>GET, POST /auth/activate</pre>

* query parametry - user_id, token, redirect
* odpoved: <code>302 Redirect</code>

h3. zmena hesla

<pre>POST /auth/change_password</pre>

* vyzaduje prihlaseni (token)
* parametry v tele - current_password, new_password
* odpoved: <code>204 No Content</code>

h3. iniciace resetu hesla - odesle email s linkem pro reset

<pre>POST /auth/init_password_reset</pre>

* query parametry: email, redirect
* odpoved: <code>204 No Content</code>

h3. dokonceni resetu hesla - nastavi nove heslo

<pre>POST /auth/reset_password</pre>

* query parametry: user_id, token
* parametr v tele: password
* odpoved: <code>204 No Content</code>

h3. smazani uzivatele

<pre>DELETE /auth/delete_user</pre>

* vyzaduje prihlaseni (token)
* nema zadne parametry - maze prihlaseneho uzivatele
* odpoved: <code>204 No Content</code>

h3. sprava uzivatelu

<pre>/auth/crud/users</pre>

* standardni set 6 generickych CRUD rout
* vyzaduje administrativni prava

h2. Klientske routy

h3. prihlaseni klienta

<pre>POST /auth/get_client_token</pre>

* parametry v tele: username, password
* odpoved:

<pre><code class="json">
{
    "client": {
        "address": {},
        "card_id": "123",
        "client_id": "123",
        "comment": null,
        "company": {},
        "created_at": "2017-09-04T11:23:46.357805Z",
        "email": "test@test.cz",
        "expiration_date": null,
        "firstname": null,
        "id": 1,
        "links": {
            "orders": "/clients/1/orders/"
        },
        "news": false,
        "personal": {},
        "status": "A",
        "surname": null,
        "updated_at": "2017-09-05T14:26:10.521270Z"
    },
    "token": "6f570e9a4c0909ebd80d16fc63549b4d8b6f799c",
    "user": {
        "client": 1,
        "date_joined": "2017-09-05T14:26:10.466902Z",
        "email": "test@test.cz",
        "first_name": "",
        "id": 7,
        "is_active": true,
        "is_staff": false,
        "is_superuser": false,
        "last_login": null,
        "last_name": "",
        "username": "test3"
    }
}
</code></pre>

h3. vyhledani klienta podle cisla karty

<pre>GET /auth/client_by_card</pre>

* slouzi jako prvni krok registrace
* query parametr: card_id
* odpoved:

<pre><code class="json">
{
    "id": 1,
    "registered": false
}
</code></pre>

h3. registrace klienta

<pre>POST /auth/register_client</pre>

* query parametry: client_id, redirect (kam ma presmerovat aktivacni email)
* parametry v tele: username nebo use_email_as_username, password
* email, first_name a last_name se vezme z klienta (email, firstname, surname)
* odpoved:

<pre><code class="json">
{
    "user": {
        "date_joined": "2017-09-05T14:26:10.466902Z",
        "email": "test@test.cz",
        "first_name": "",
        "id": 7,
        "is_active": false,
        "is_staff": false,
        "is_superuser": false,
        "last_login": null,
        "last_name": "",
        "username": "test3"
    }
}
</code></pre>

h3. ziskani informaci o prihlasenem klientu

<pre>GET /auth/get_client</pre>

* slouzi k vyplneni formulare pro editaci profilu
* vyzaduje prihlaseni
* nema zadne parametry
* odpoved:

<pre><code class="json">
{
    "client": {
        "address": {},
        "card_id": "123",
        "client_id": "123",
        "comment": null,
        "company": {},
        "created_at": "2017-09-04T11:23:46.357805Z",
        "email": "test@test.cz",
        "expiration_date": null,
        "firstname": null,
        "id": 1,
        "links": {
            "orders": "/clients/1/orders/"
        },
        "news": false,
        "personal": {},
        "status": "A",
        "surname": null,
        "updated_at": "2017-09-05T14:34:06.813614Z"
    }
}
</code></pre>

h3. editace informaci o prihlasenem klientu (profilu)

<pre>PATCH /auth/edit_client</pre>

* vyzaduje prihlaseni
* parametry v tele odpovidaji polim klienta (funguje stejne jako CRUD routa pro castecnou upravu zaznamu)
* odpoved:

<pre><code class="json">
{
    "client": {
        "address": {},
        "card_id": "123",
        "client_id": "123",
        "comment": null,
        "company": {},
        "created_at": "2017-09-04T11:23:46.357805Z",
        "email": "test@test.cz",
        "expiration_date": null,
        "firstname": null,
        "id": 1,
        "links": {
            "orders": "/clients/1/orders/"
        },
        "news": false,
        "personal": {},
        "status": "A",
        "surname": null,
        "updated_at": "2017-09-05T14:34:06.813614Z"
    }
}
</code></pre>

h3. smazani klientskeho uctu administratorem

<pre>DELETE /auth/delete_client_user</pre>

* vyzaduje prihlaseni (administrativni ucet)
* query parametr: client_id
* odpoved: <code>204 No Content</code>
