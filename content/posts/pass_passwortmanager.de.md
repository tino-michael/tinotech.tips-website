---
title: "pass, der Unix Passwortmanager"
date: 2022-01-05T08:59:05+02:00
authors: ["Tino Michael"]
categories: ["Workflow"]
tags: ["sicherheit", "linux"]
summary: |
    Es gibt eine schier endlose Auswahl an Passwortmanagern und alle warten sie mit ihren 
    angeblichen Alleinstellungsmerkmalen auf.
    In diesem Artikel möchte ich `pass`, den GNU Passwortmanager, vorstellen und vielleicht den ein
    oder anderen überzeugen, ihn auch zu benutzen.
---

Gerade heute habe ich eine Geschichte von "L. T. aus R." gehört, wie sie ihre Passwörter auf ihrem
Laptop verwaltet: Einfach alles in eine große Textdatei werfen.
Wenn es auf eine längere Reise geht, auf die der Laptop nicht mit soll, werden eventuell benötigte
Passwörter in ein E-Mail-Draft auf GMail gespeichert.
Da haben sich mir natürlich erst einmal die Nackenhaare aufgestellt.
Es gibt eine schier endlose Auswahl an Passwortmanagern und alle warten sie mit ihren angeblichen
Alleinstellungsmerkmalen auf.
Es sollte sich also bestimmt eine bessere Alternative finden lassen, als alle seine Passwörter in
einer Google E-Mail zu speichern.

## Die Unix Philosophie

Meine eigene Wahl fiel dabei auf `pass`, den standard Unix Passwortmanager.
`pass` ist ein minimalistisches Konsolenprogramm, dass der etablierten Unix-Philosophie folgt:
Schreibe für jedes Problem ein atomares (d.h. eigenständiges) Program,
das **eine** Aufgabe erledigt und diese sehr gut.
Statt das Program mit Zusatzfunktionen zu überschütten und alles neu zu implementieren,
setze es so auf, dass es mit anderen, etablierten Programmen zusammenarbeitet.
Dabei nutzt `pass` `GnuPG` um Passwörter in einzelnen Textdateien zu verschlüsseln.
Diese Textdateien können in einer beliebigen Ordnerhierarchie organisiert werden.
Synchronisierung mit anderen Geräten wird über `git` ermöglicht.
(Da die Passwörter verschlüsselt sind, kann man sie sogar auf z.B. GitHub ablegen und hat so von
überall Zugriff.)
Zwar liefert `pass` selbst keine graphische Oberfläche mit, es existieren jedoch einige
eigenständige Projekte, die eine solche anbieten.

## Passwort Store aufsetzen

Der Ort, an dem `pass` die Passwörter ablegt, wird durch die `PASSWORD_STORE_DIR` Umgebungsvariable
definiert. Ist sie nicht gesetzt, wird auf `$HOME/.password-store` zurückgegriffen.
Bei mir wohnt der Passwort Store in folgendem Ordner: `PASSWORD_STORE_DIR=${XDG_DATA_HOME}/password-store`.

Zum Aufsetzen des Stores benötigt man noch einen [PGP-Schlüssel]({{< ref generate_gpg_keys >}}).

Hat man sich für einen Ort entschieden, kann der `pass` Store durch folgenden Befehl initialisiert
werden:

```shell
$ pass init <PGP-Schlüssel-ID>
mkdir: created directory '~/.local/share/password-store'
Password store initialized for <PGP-Schlüssel-ID>
```

Den gesamten Passwort Store kann man ganz einfach als git-Repo initialisieren:

```shell
$ pass git init
Initialized empty Git repository in ~/.local/share/password-store/.git/
```

Dann fügt man ein Remote hinzu, z.B. auf GitHub oder einem eigenen Webserver:

```shell
$ pass git remote add origin <Remote-Adresse>
```

Von nun an erzeugt `pass` automatisch für jede Änderung an den Passwörtern einen git-commit,
die man mit den git-typischen Befehlen mit dem Remote und anderen Geräten synchronisieren kann.
(Wer git kennt, sieht, es kommt einfach noch ein `pass` vor den git-Befehl.)

## Benutzung

`pass` liefert eine handvoll an Befehlen um neue Passwörter anzulegen und bestehende Passwörter zu
editieren, suchen, anzuzeigen oder in die Zwischenablage zu kopieren
(um sie nicht in Klartext anzeigen zu müssen).

Neue Passwörter können mit einem simplen Befehl erzeugt werden:

### Einträge anlegen,

```shell
$ pass generate shopping/amazon.de
The generated password for shopping/amazon.de is:
+LYty/UE>le::}G%O@!;JU.B$
```

Damit das frisch generierte Passwort nicht im Klartext in der Konsole angezeigt wird, kann man die
`-c` Flagge verwenden. Damit wird das Passwort in die Zwischenablage kopiert und nach 45 Sekunden
wieder gelöscht:

```shell
$ pass generate -c shopping/lidl.de
Copied shopping/lidl.de to clipboard. Will clear in 45 seconds.
```

Falls man für eine Seite bereits ein Passwort hat und kein neues generieren möchte, kann man dieses
mit `insert` in den Passwort Store hinzufügen:

```shell
$ pass insert email/gmx.de
Enter password for email/gmx.de:
Retype password for email/gmx.de:
```

Möchte man mehr als nur das Passwort hinterlegen, zum Beispiel auch noch den Benutzernamen oder 
Sicherheitsfragen, kann man mit `multiline` mehrere Zeilen in einem Eintrag abspeichern.
Persönlich nutze ich statt `insert` und `multiline` eher den `edit` Befehl, welcher den Eintrag
unverschlüsselt im Standardtexteditor öffnet (definiert durch die `$EDITOR` Umgebungsvariable; oder
`vi` falls sie nicht gesetzt ist).
Im Texteditor kann man frei Rumeditieren und nach Belieben Leerzeilen einfügen.
Das funktioniert auch für komplett neue Einträge.
Man muss also nicht erst ein Passwort anlegen, bevor man es editieren kann.

```shell
$ pass edit email/google.de

# editing:
1  meinpasswort
2  user: meine_mail@gmail.com
3
4  Frage 1: Antwort 1
5  Frage 2: Antwort 2
```

### ... und wieder auslesen

Wieder auslesen kann man die angelegten Passwörter wie folgt

```shell
$ pass show shopping/amazon.de
+LYty/UE>le::}G%O@!;JU.B$
```

Wobei das `show` hier optional ist und ich es in der Regel weg lasse.
Genau wie beim generieren kann auch beim Auslesen mit der `-c` Flagge das Passwort in die
Zwischenablage kopiert werden, ohne dass es in der Konsole selbst angezeigt wird.
Die `-c` Flagge kopiert dabei stets die erste Zeile des Eintrages, auch wenn es sich um einen
"multiline" Eintrag hält.

```shell
$ pass -c shopping/amazon.de
Copied shopping/amazon.de to clipboard. Will clear in 45 seconds.
```

Eine Übersicht über alle vorhandenen Einträge bekommt man ganz einfach mit `pass` ohne weitere Zusätze:

```shell
$ pass
Password Store
├── email
│   ├── gmx.de
│   └── google.de
└── shopping
    ├── amazon.de
    └── lidl.de
```

Man kann diese Auflistung auch auf Unterordner beschränken:

```shell
$ pass email
email
├── gmx.de
└── google.de
```

Wenn man sich nicht ganz sicher ist, in welchem Pfad ein Eintrag genau wohnt, kann man ihn mit
`pass find` suchen:

```shell
$ pass find gmx
Search Terms: gmx
└── email
    └── gmx.de
```

Zum Auslesen der Passwörter benutze ich neben der Konsole auch noch ein selbst geschriebenes
`dmenu`-Skript und das Chrome-Plugin `browserpass`.

### pass_menu

`pass_menu` ist mein [dmenu](https://wiki.archlinux.org/title/Dmenu) (bzw. [rofi](https://wiki.archlinux.org/title/Rofi))
Wrapper-Skript für `pass` und auf
[meinem GitHub](https://github.com/tino-michael/dot_configs/blob/main/local/bin/pass_menu) zu finden.
Es listet alle Einträge aus dem Passwort Store in einem Popup-Menu auf.
In dem Menü kann man über das Textfeld nach Einträgen suchen und sie mit der Entertaste auswählen.
Mit dieser Auswahl wird die Datei entschlüsselt und das Passwort für 45 Sekunden in die Zwischenablage
kopiert.

{{< gallery/gallery
    caption="Dmenu Auflistung aller Einträge im Passwort Store. Über das Textfeld können die Einträge gefiltert werden. Wird ein Eintrag mit der Entertaste ausgewält, wird das entpsrechende Passwort für 45 Sekunden in die Zwischenablage gespeichert."
    ncol=5
>}}
{{< gallery/image
    src="/img/posts/pass/pass_menu.webp"
    alt="Dmenu Auflistung aller Einträge im Passwort Store"
    cols="2/5"
>}}
{{< /gallery/gallery >}}

### browserpass

`browserpass` ist ein extrem nützliches Browser-Plugin (gibt es für Firefox und Chrome-basierte Browser),
das als Schnittstelle zwischen Browser und dem Passwort Store fungiert.
Wenn man die Login-Seite einer Webseite ansteuert, findet `browserpass` automatisch die entsprechenden
Zugangsdaten und fügt sie per Tastenkombination in die Login-Felder ein.
Was man dabei allerdings noch beachten sollte, erkläre ich lieber in einem 
[anderen Artikel]({{< ref pass_browserpass >}}).

{{< gallery/gallery
    caption="Das browserpass Plugin erkennt die aktuelle Webseite und findet die entpsrechenden Login-Daten. Diese können über eine Tastenkombination auf der Webseite eingetragen werden."
    ncol=5
>}}
{{< gallery/image
    src="/img/posts/pass/browserpass.webp"
    alt="browserpass plugin erkennt Webseite und findet entsprechende Login-Daten"
    cols="2/5"
>}}
{{< /gallery/gallery >}}
