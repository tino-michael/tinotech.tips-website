---
title: "Passwörter nie mehr abspeichern"
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

Passwortsicherheit ist ein ewiges Thema.
Der Fokus liegt zumeist auf der Komplexität eines Passworts.
Doch die große Frage ist, wie kommt man an das Passwort wieder heran, wenn man es braucht?
In [meinem anderen Artikel]({{< ref "pass_passwortmanager" >}}) habe ich *pass*,
einen minimalistischen Passwortmanager, vorgestellt, der aber immer noch davon abhängt,
die Passwörter (verschlüsselt) irgendwo abzuspeichern.
Wem *pass* nicht minimalistisch genug ist, den kann ich ja vielleicht mit folgendem Ansatz
begeistern, die Passwörter mit einer deterministischen
[Hashfunktion](https://de.wikipedia.org/wiki/Hashfunktion "Hashfunktion") und einem geheimen
[Salt](https://de.wikipedia.org/wiki/Salt_(Kryptologie) "Salt (Kryptologie)")
(ein zusätzlicher, persönlicher Code) bei Bedarf jedes Mal neu zu generieren.

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

## Sonderzeichen und Passwortlänge

Dem aufmerksamen Leser wird auffallen, dass diese Hashfunktion nur Zahlen und kleine Buchstaben bis
"f" erzeugt (es wird ein Bitstream erzeugt, der Byte-weise im Hexadezimalformat dargestellt wird).
Viele Webseiten verlangen jedoch aus "Sicherheitsgründen", dass im Passwort auch Großbuchstaben
und Sonderzeichen vorkommen sollen.
Bevor man jetzt den Hashwert nach z.B. ASCII konvertiert (und sich überlegt, was man mit den ganzen
nicht-druckbare Zeichen machen soll), ist eine simple Idee:
Fügt einfach eine konstante Zeichenkette vor den Hash, der eine Auswahl der verlangten Zeichen enthält,
etwa:

```shell
… | awk -v prefix='!AB_' '{print prefix$1}' | …
```

Für wen das nicht akzeptable ist und wer nicht vor noch längeren shell-pipes zurückschreckt, kann
natürlich tatsächlich die Hex-Werte nach ASCII konvertieren und auf die druckbaren Zeichen reduzieren:

```shell
… | sed -e 's/\ -//' -e 's/\([0-9A-F]\{2\}\)/0x\1\ /gI' | xargs printf "%d " | awk 'BEGIN {RS=" ";} {if ($1 <= 32) {$1 += 32}  while ($1 >= 126) { $1 -= (126-32) } {printf "%c", $1} }' | …
```

Die *sha-256* Hashfunktion erzeugt einen 256-Bit, d.h. 64 Hexadezimalzeichen, langen Hashwert.
Wem das als Passwort zu lang ist (es gibt Webseiten, die eine Maximallänge vorgeben),
kann es ganz einfach mit einem `cut -c1-20` kürzen.
Die vollständige Implementierung sieht am Ende dann so aus:

```shell
#!/bin/sh
printf $1$2 | sha256sum | awk -v prefix='!AB_' '{print prefix$1}' | cut -c1-20
```

(bzw. mit der `sed`-`awk`-pipe von oben)

## Vor- und Nachteile

Der große Vorteil dieses Ansatzes ist, dass die Passwörter wirklich nirgendwo mehr gespeichert werden.
Man muss sich nur noch einen Salt merken und kann die Passwörter immer und überall
-- auch auf fremden Computern -- generieren, ohne befürchten zu müssen, kompromittiert zu werden.

Der Nachteil dieses Ansatzes ist, dass alle Passwörter über den Salt zusammenhängen.
Wenn ein einzelnes Passwort kompromittiert wurde, etwa weil eine Webseite gehackt wurde, kann nicht
nur dieses eine Passwort geändert werden. Man muss den Salt ändern, womit sich das Passwort für
**alle** Webseiten ändert.

Ein anderer Punkt, den man bedenken sollte: Wenn ein "Angreifer" in einen Passwort Store eindringt,
sind "nur" alle aktuellen Passwörter kompromittiert. Wenn jemand den aktuellen Salt herausfindet,
sind mit einem Mal auch alle potentiellen zukünftigen Passwörter bekannt.

## Fazit

Dieser letzte Punk ist allerdings nur sehr theoretischer Natur, falls man nicht tatsächlich von
irgendwelchen Geheimdiensten oder anderen Regimen verfolgt wird;
und selbst dann geht es meist ganz anders zu, als viele es sich vorstellen.
Am Ende geht es für die allermeisten eher darum, halbwegs vernünftige Passwörter zu erzeugen,
und nicht überall das gleiche zu verwenden.
Außerdem möchte man an die Passwörter auch relativ praktisch wieder herankommt, wenn man sie braucht;
und dafür ist dieser Ansatz absolut zu gebrauchen.

{{< gallery/gallery
    caption="How Hacking Works by xkcd.com"
>}}
    {{< gallery/image
        src="https://imgs.xkcd.com/comics/how_hacking_works_2x.png"
        alt="xkcd -- How Hacking Works"
    >}}
{{< /gallery/gallery >}}
