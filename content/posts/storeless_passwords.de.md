---
title: "Passwörter verwalten ganz ohne sie abzuspeichern"
date: 2022-01-27T15:00:00+01:00
authors: ["Tino Michael"]
categories: ["Workflow"]
tags: ["Sicherheit", "shell"]
# banner:
summary: |
    In einem anderen Artikel habe ich mit *pass* einen minimalistischen Passwortmanager vorgestellt,
    der immer noch davon abhängt, die Passwörter abzuspeichern.
    Wem *pass* nicht radikal minimalistisch genug ist, den kann ich ja vielleicht mit folgendem Ansatz
    begeistern, die Passwörter mit einer Hashfunktion bei Bedarf jedes Mal neu zu generieren.
---

In meinem anderen [Artikel]({{< ref "pass_passwortmanager" >}}) habe ich mit *pass*
einen minimalistischen Passwortmanager vorgestellt, der immer noch davon abhängt,
die Passwörter (verschlüsselt) irgendwo abzuspeichern.
Wem *pass* nicht radikal minimalistisch genug ist, den kann ich ja vielleicht mit folgendem Ansatz
begeistern, die Passwörter mit einer deterministischen
[Hashfunktion](https://de.wikipedia.org/wiki/Hashfunktion "Hashfunktion") und einem geheimen
[Salt](https://de.wikipedia.org/wiki/Salt_(Kryptologie) "Salt (Kryptologie)") bei Bedarf jedes Mal
neu zu generieren.

Dazu nehme man eine [kryptologisch sichere](https://de.wikipedia.org/wiki/Hashfunktion#Kriterien)
Hashfunktion (z.B. sha-256 oder argon2) und denkt sich einen Salt aus, welcher sozusagen als
Master-Passwort fungiert.
Die URL der Webseite, für die man ein Passwort braucht, ist der Input der Hashfunktion,
der "gesalzene" Hash ist das Passwort.

Wenn man mal an einem anderen Computer sitzt, braucht man mit diesem Ansatz nie mehr verzweifeln,
dass man gerade seinen Passwort Vault nicht dabei hat.
Man braucht lediglich die URL der Webseite, auf der man sich einloggen möchte,
die Hashfunktion und den Salt, den man sich gemerkt hat.

Eine Implementierung könnte in *(ba- / z- / da-)sh* etwa so aussehen:

```shell
$ cat sha_pw
#!/bin/sh
printf $1$2 | sha256sum | awk '{print $1}'

$ sha_pw tinotech.tips GEHEIM_SALT
c2dfa080cf358eaf57e2a1d4b2105ae9338d69e81ea33f9fc4aa932ac6a70ffe
```

Wenn man das Passwort nicht im Klartext in der Konsole haben möchte, kann man es natürlich auch
gleich in die Zwischenablage kopieren:

```shell
#!/bin/sh
printf $1$2 | sha256sum | awk '{print $1}' | xclip -selection clipboard
```

## Sonderzeichen und Passwortlänge?

Dem aufmerksamen Leser wird auffallen, dass die Hashfunktion nur Zahlen und kleine Buchstaben bis "f"
erzeugt (es wird ein Bitstream erzeugt, der Byte-weise im Hexadezimalformat dargestellt wird).
Viele Webseiten verlangen jedoch aus "Sicherheitsgründen", dass auch Großbuchstaben und Sonderzeichen
vorkommen sollen.
Bevor man jetzt den Hashwert nach z.B. ASCII konvertiert (und sich überlegt, was man mit den ganzen
nicht-druckbare Zeichen machen soll), ist meine Idee viel simpler:
Fügt einfach eine konstante Zeichenkette vor den Hash, der eine Auswahl der verlangten Zeichen enthält,
etwa:

```shell
... | awk -v prefix='!AB_' '{print prefix$1}' | ...
```

Wem das Passwort zu lang ist (es gibt Webseiten, die eine Maximallänge vorgeben), kann es ganz einfach
mit einem `cut -c1-20` kürzen.
Die vollständige Implementierung sieht am Ende dann so aus:

```shell
#!/bin/sh
printf $1$2 | sha256sum | awk -v prefix='!AB_' '{print prefix$1}' | cut -c1-20
```

## Nachteile

Der Nachteil dieses Ansatzes ist, dass alle Passwörter über den Salt zusammenhängen.
Wenn ein einzelnes Passwort kompromittiert wurde, etwa weil eine Webseite gehackt wurde, kann nicht
nur dieses eine Passwort geändert werden. Man muss den Salt wechseln, womit sich das Passwort für
**alle** Webseiten ändert.

Ein anderer Punkt, den man bedenken sollte: Wenn ein "Angreifer" in einen Passwort Store eindringt,
sind "nur" alle aktuellen Passwörter kompromittiert. Wenn jemand den aktuellen Salt herausfindet,
sind mit einem Mal auch alle potentiellen zukünftigen Passwörter bekannt.
