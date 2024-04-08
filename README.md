# Relaatiotietokantojen perusteet

Tämä repo sisältää osan opintojakson materiaaleista.

## Tietokannan lisääminen

`Databases`-hakemisto sisältää tietokantoja, joita käytetään videoilla/harjoituksissa.

Käyttöönottoon vaaditaan vain pari vaihetta.

### 1. Lataa `.sql`-tiedosto palvelinkoneelle

Esimerkiksi `store_small.sql` lataaminen tapahtuu komennolla:

```bash
wget https://raw.githubusercontent.com/Juho-courses/relaatiotietokantojen-perusteet-2024/main/databases/store_small.sql
```

### 2. Luo uusi tietokanta

Uusi tietokanta pitää luoda, jotta sinne voidaan ajaa sisään tauluja ja dataa.

```sql
CREATE DATABASE store;
```

### 3. Ajetaan data sisään

Ladatun `.sql`-tiedoston sisältö ajetaan luotuun tietokantaan (`store` on tietokannan nimi):

```bash
mysql -uadmin -p store < store_small.sql
```

### 4. Valmis

Voit käyttää tietokantaa.

## Copyright

Juho Salli. Käyttö vain luvalla.
