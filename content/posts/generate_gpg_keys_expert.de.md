---
Title: "GPG-Schlüssel generieren — Expertenmodus"
date: 2022-02-04T21:00:00+02:00
banner: "img/posts/encryption/keys_labelled.webp"
authors: ["Tino Michael"]
categories: ["Workflow"]
tags: ["sicherheit"]
summary: |
    Ich habe bereits eine kurze Anleitung gegeben, wie man sich schnell ein GPG-Schlüsselpaar
    generieren kann.
    Allerdings bietet *gpg* im expert-Modus noch einige weitere Möglichkeiten,
    die erzeugten Schlüssel an die eigenen Anforderungen anzupassen.
    Von diesem Expertenmodus möchte ich hier mehr berichten.
---

Ich habe bereits [hier]({{< ref "generate_gpg_keys" >}} "GPG-Schlüssel generieren")
eine kurze Anleitung gegeben, wie man sich schnell ein GPG-Schlüsselpaar generieren kann.
Allerdings bietet *gpg* im `expert`-Modus noch einige weitere Möglichkeiten,
die erzeugten Schlüssel an die eigenen Anforderungen anzupassen.
So kann man neben dem klassischen
[RSA-Verfahren](https://de.wikipedia.org/wiki/RSA-Kryptosystem "RSA-Kryptosystem – Wikipedia") auch
[elliptische Kurven (ECC)](https://de.wikipedia.org/wiki/Elliptic_Curve_Cryptography "Elliptic Curve Cryptography – Wikipedia")
als Verfahren zur Schlüsselerzeugung auswählen.
Außerdem kann man granular die Fähigkeiten der einzelnen Schlüssel festlegen.
So kann man einen Hauptschlüssel mit dedizierten Subschlüsseln zum Verschlüsseln, Signieren,
Authentifizieren und das Zertifizieren anderer Schlüssel anlegen.

## Masterschlüssel mit dedizierten Subschlüsseln generieren

Der Expertenmodus wird mit der Flagge `--expert` aufgerufen:

```shell
$ gpg --full-generate-key --expert
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
   (9) ECC and ECC
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (13) Existing key
  (14) Existing key from card
Your selection?
```

In dieser erweiterten Auswahl kann man zum Beispiel elliptische Kurven Schlüssel (ECC) auswählen
und sich Schlüssel erzeugen, die nur eine begrenzte Auswahl an Fähigkeiten haben
("set your own capabilities").

```shell
Your selection? 11

Possible actions for a ECDSA/EdDSA key: Sign Certify Authenticate
Current allowed actions: Sign Certify

   (S) Toggle the sign capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection?
```

Der Hauptschlüssel soll nur zertifizieren können, das Signieren wird also mit `s` abgewählt und mit
`q` bestätigt.
Als nächstes soll man sich für eine der elliptischen Kurven entscheiden. Der Standard ist `Curve 25519`.

```shell
Please select which elliptic curve you want:
   (1) Curve 25519
   (3) NIST P-256
   (4) NIST P-384
   (5) NIST P-521
   (6) Brainpool P-256
   (7) Brainpool P-384
   (8) Brainpool P-512
   (9) secp256k1
Your selection? 1
```

Danach folgen die Abfragen für Gültigkeit und persönliche Angaben, wie im nicht-expert Modus.
Am Ende der Ausgabe sieht man wieder den gerade erzeugten Schlüssel, diesmal nur für das
Zertifizieren anderer Schlüssel (erkennbar am `[C]`).

```shell
pub   ed25519 2022-01-19 [C]
      EB9130A6DFB64D65B222CE4AC5A7A34F515A9110
uid                      Tino M <info@tinotech.tips>
```

Um nun weitere Subschlüssel hinzuzufügen, ruft man `gpg --expert --edit-key` mit der ID,
des gerade generierten Schlüssels auf.
Darauf erscheint eine interaktive Shell, erkennbar am `gpg>`-Prompt, in der man mit `addkey` weitere
Schlüssel definieren und hinzufügen kann.

```shell
$ gpg --expert --edit-key EB9130A6DFB64D65B222CE4AC5A7A34F515A9110
Secret key is available.

gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
sec  ed25519/C5A7A34F515A9110
     created: 2022-01-19  expires: never       usage: C
     trust: ultimate      validity: ultimate
[ultimate] (1). Tino M <info@tinotech.tips>

gpg> addkey
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Your selection?
```

Hier kann man nun sukzessive Schlüssel mit den gewünschten Fähigkeiten erzeugen, sodass es am Ende
etwa so aussieht:

```shell
sec  ed25519/C5A7A34F515A9110
     created: 2022-01-19  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  ed25519/08632EEED3B39FA9
     created: 2022-01-19  expires: never       usage: A
ssb  cv25519/B804C9CA05282C28
     created: 2022-01-19  expires: never       usage: E
ssb  ed25519/53BC005989A116B1
     created: 2022-01-19  expires: never       usage: S
[ultimate] (1). Tino M <info@tinotech.tips>

gpg>
```

Nun hat man einen dedizierte Schlüssel um etwa E-Mails zu signieren und einen anderen um Dateien
zu verschlüsseln (z.B. seinen [pass Password Store]({{< ref "pass_passwortmanager" >}})).
Man kann sich auch leicht einen zweiten Signatur-Schlüssel erzeugen, um etwa einen privat und den
anderen beruflich zu verwenden.

## RSA oder elliptische Kurven

Ob man RSA oder elliptische Kurven für die Erzeugung der Schlüssel benutzt, hängt vom eigenen
Anwendungsfall ab.
RSA ist lange etabliert und weit verbreitet. Wenn Kompatibilität mit älterer Hard- und Software
ein Problem sein könnte, sollte man auf RSA zurückgreifen.
Das GPG-Team schreibt auf ihrer Seite selbst, dass elliptische Kurven "die Zukunft" sind.
Wenn Rückwärtskompatibilität kein Thema ist, kann man problemlos ECC verwenden.
