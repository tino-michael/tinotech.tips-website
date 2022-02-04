---
Title: "GPG-Schlüssel generieren"
date: 2022-01-18T01:40:00+02:00
# banner:
authors: ["Tino Michael"]
categories: ["Workflow"]
tags: ["sicherheit"]
draft: true
#  summary:
---

GPG ist die offene Implementierung des OpenPGP-Standards und eines der Standard-Tools in der Linux-Welt.
Es wird benutzt um sowohl E-Mails als auch ganze Datenträger zu verschlüsseln und zu signieren.
Dabei werden stets ein öffentlicher (public) und ein privater (private) Schlüssel als Paar benutzt.
Anleitungen, wie man GPG-Schlüssel erzeugt gibt es bereits wie Sand am Meer,
da ich aber in einem [anderen Artikel]({{< ref pass_passwortmanager >}} "pass, der Unix Passwortmanager")
diese Schlüssel kurz anspreche, hier nun auch noch einmal der Vollständigkeit halber einen kurzen Abriss dazu.

## Schlüssel generieren

Der Befehl `gpg --full-generate-key` führt einen interaktiv durch die Erzeugung eines frischen Schlüsselpaares:

```shell
$ gpg --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection?
```

Sowohl RSA als auch DSA und Elgamal gelten als "sicher". Es wird jedoch schlicht wegen der weit
verbreiteten Unterstützung generell empfohlen, RSA zu benutzen.

```shell
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
```

Bei der Schlüsselgröße gibt es mittlerweile keinen Grund, nicht das Maximum von 4096 zu wählen.
(Es sei denn, man hat es tatsächlich noch mit älterer Hard- bzw. Software zu tun,
welche diese Schlüsselgröße nicht unterstützen...)

```shell
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
```

Als nächstes gilt es, auszuwählen, wie lange der Schlüssel gültig sein soll.
Wenn ein Schlüssel nicht länger gültig ist, kann er nicht mehr zum ver- / entschlüsseln oder
signieren verwendet werden. Die Gültigkeit lässt sich allerdings später nach belieben verlängern.
Welchen Gültigkeitszyklus man wählt, darf jeder für sich selbst entscheiden.
Es bieten sich ein, zwei Jahre an oder gleich `0` zu wählen und den Schlüssel niemals verfallen zu lassen.

```shell
Key is valid for? (0) 0
Key does not expire at all
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: Tino M
Email address: email@adresse.de
Comment:
You selected this USER-ID:
    "Tino M <email@adresse.de>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit?
```

Als nächstes fragt `gpg` noch nach einem Namen, E-Mail-Adresse und Kommentar, welche in das neue
Schlüsselpaar gespeichert werden. Der Kommentar kann auch leer bleiben.
Danach kann man den neuen Schlüssel noch mit einem Passwort absichern.
Zum Abschluss wird noch eine kurze Übersicht über den erstellten Schlüssel ausgegeben.
Die längliche alphanumerische ID `3845...` ist dabei die ID, die beim Initialisieren des *pass*
Passwort Stores angegeben werden soll
([siehe hier]({{< ref pass_passwortmanager >}} "pass, der Unix Passwortmanager")).

```shell
pub   rsa4096 2022-01-18 [SC]
      3845DAD8C36A7E338CA17A9827099214703619CD
uid                      Tino M <email@adresse.de>
sub   rsa4096 2022-01-18 [E]
```

## Expertenmodus

Wer ein bisschen mehr Auswahl bei der Schlüsselerzeugung haben möchte,
kann `gpg` auch im `expert`-Modus starten.
Um diesen Artikel hier aber kurz und knapp zu halten, gehe ich darauf aber
lieber in einem [anderen Artikel]({{< ref "generate_gpg_keys_expert" >}} "GPG Expertenmodus") ein.

## Letzte Worte

Natürlich ist kaum ein Artikel über Verschlüsselungen komplett, ohne auf einen gewissen
[xkcd](https://xkcd.com/538/) Comic zu verweisen:

{{< gallery/gallery
    caption="<i>Security — Actual actual reality: nobody cares about his secrets.</i>  von xkcd.com"
>}}

{{< gallery/image
    src="https://imgs.xkcd.com/comics/security.png"
>}}

{{< /gallery/gallery >}}
