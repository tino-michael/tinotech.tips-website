---
title: "Mehr Details zum Librem 5"
date: 2021-11-03T08:58:05+02:00
banner: "/img/posts/librem_5/banner.webp"
authors: ["Tino Michael"]
categories: ["Gadgets"]
tags: ["librem", "pure_os", "privacy", "linux", "open_source"]
summary: "In diesem Begleitartikel möchte ich nun etwas mehr ins Detail gehen und einige auch kleinere Dinge ansprechen, die mir beim Herumspielen aufgefallen sind."
---

In meinem [Librem 5 Hauptartikel](../librem_5) habe ich von meinem generellen ersten Eindruck berichtet.
In diesem Begleitartikel möchte ich nun etwas mehr ins Detail gehen und auch einige kleinere Dinge
ansprechen, die mir beim Herumspielen aufgefallen sind.

### Applikationen

Die Menge der vorinstallierten Programme ist übersichtlich.
In den Favoriten gibt es eine Telephonfunktion, Chat, Browser und Kontakte.
Im Hauptmenü findet man unter anderem ein paar Spiele (Schach und 2048), E-Mail,
Photo- und PDF-Viewer und sogar einen Texteditor und ein Terminal.
Mit den "PureOS Store" können weitere Programme wie von einem App-Store gewohnt hinzugefügt werden.
Alle nötigen Basisprogramme sind da. Auf unnützen Bloat wurde verzichtet
(je nach dem wie man zu den Spielen steht).
Auf dem Purism Blog findet man ein paar nützliche Tips, wie man schnell weitere Applikationen
selbst hinzufügen kann. Zum Beispiel ein simples Programm um
[Bildschirmphotos](https://puri.sm/posts/easy-librem-5-app-development-take-a-screenshot/)
zu schießen; was ich auch gleich umgesetzt habe und womit ich alle Screenshots hier in diesem
Eintrag gemacht habe.
Dazu muss man ins Terminal und erst mal ein paar Programme nachinstallieren.
Die Installation mit `apt-get` funktioniert so problemlos, wie man es von einem Debian-basierten
Linux erwarten darf.
Die zwei im Blog erwähnten Textdateien sind schnell geschrieben und per `ssh` vom Laptop rüber kopiert;
schon erscheint ein neues Icon im Programmmenü.
Jedoch: Ich musste in die `.desktop` noch folgende Zeile hinzufügen, damit das Programm als
"adaptiv" erkannt und im mobil-Modus angezeigt wird:

```X-Purism-FormFactor=Workstation;Mobile;```

### Onscreen-Tastatur

Das Tastaturlayout kann unter "Region und Sprache" angepasst werden, [Neo2](https://www.neo-layout.org/)
ist sogar auch dabei. Allerdings hat diese Layoutvariante scheinbar keine Auswirkung auf die
Onscreen Tastatur, welche bei "QWERTZ" bleibt.
Es ändert sich lediglich das Layout für eine extern angeschlossene Tastatur.
Im Purism Blog gibt es einen [Eintrag](https://puri.sm/posts/librem-5-keyboard-improvements/), der
über die Tastatur berichtet und auf dessen
[GitLab Repository](https://source.puri.sm/Librem5/squeekboard) verweist.
Nach ein wenig Rumstöbern bekommt man eine Idee, wie man ein eigenes Layout für das
virtuelle Keyboard hinzufügen könnte. Ich habe es bisher jedoch noch nicht ausprobiert.

{{< gallery/gallery
    ncol=3
    caption="Region- und Sprachenauswahl im Einstellungsmenü. Die Onsrceen-Tastatur ist eingeblendet und zeigt ein ausgewähtles \"Deutsch (Neo 2)\" Layout. Die Belegung ist aber dennoch optisch und funktional QWERTZ."
>}}
    {{< gallery/image
        cols="2/3"
        src="/img/posts/librem_5/librem_5_screenshot_keyboard.webp"
        alt=""
    >}}
{{< /gallery/gallery >}}

### Display

Laut "Displays" Menü ist der Bildschirm mit 720 &times; 1440 Pixeln aufgelöst.
Hier lässt sich auch ein Skalierungsfaktor einstellen.
Änderungen scheinen jedoch bei einem Neustart verworfen zu werden und man landet wieder bei dem
Standardwert von 200&nbsp;%.

### Batterie

Der Akku ist wechselbar und fasst nominell 4500&nbsp;mAh.
Allerdings hält eine volle Ladung gerade einmal einen halben Tag,
selbst wenn das Display aus ist und alle Funkmodule per Schiebeschalter stromlos gestellt sind.
Man muss also jeden Tag daran denken, das Telephon zu laden, sonst kommt es nicht einmal durch die
Nacht.

### Kamera

Die Kamera ist eher mäßig.
In der App muss man Gain, Exposure, Balance und Focus komplett manuel einstellen.
Das App Layout funktioniert nur hochkant, dreht man das Librem seitwärts, rotiert der Kameraausschnitt
noch eine Runde weiter, so dass das Bild stark verkleinert auf der Seite steht.
Ein Mal ist mir dabei auch das ganze System abgestürzt und in einer Endlos-Bootschleife hängen geblieben.
(Akku herausnehmen und wieder einsetzen hat geholfen.)
Die Photos sind gerade bei schlechteren Lichtverhältnissen stark verrauscht und können generell
nicht mit denen meines moto g7 (200 EUR Budgetphone von Anfang 2019) mithalten.

Die Selfiekamera ist sehr laggy. Als ich mit ihr rumgespielt habe ist auch mal das ganze Kamera-Modul
abgestürzt: Die App hat zwar noch funktioniert, das Bild (beider Kameras) war jedoch schwarz.
Ein Photo konnte ich in diesem Zustand auch nicht machen, nicht mal ein komplett schwarzes.
Ein Neustart war angesagt.

{{< gallery/gallery
    ncol="6"
    caption="Vergleich der Kameras des Librem 5 mit meinem moto g7 bei schwachen Lichtverhältnissen (Abends bei \"warm-weißer\" Zimmerbeleuchtung). Links jeweils das Librem, rechts das moto. Das Bild rechts unten ist von der Librem Selfiekamera zur Mittagszeit direkt am Fenster."
>}}
    {{< gallery/image
        cols="1 / 4"
        src="/img/posts/librem_5/camera/abend_keyboard_librem.webp"
        alt="alt"
    >}}
    {{< gallery/image
        cols="4 / last"
        src="/img/posts/librem_5/camera/abend_keyboard_moto.webp"
        alt="alt"
    >}}
    {{< gallery/image
        cols="1 / 3"
        src="/img/posts/librem_5/camera/abend_regal_librem.webp"
        alt="alt"
    >}}
    {{< gallery/image
        cols="3 / 5"
        src="/img/posts/librem_5/camera/abend_regal_moto.webp"
        alt="alt"
    >}}
    {{< gallery/image
        cols="5 / last"
        src="/img/posts/librem_5/camera/mittag_selfie_librem5.webp"
        alt="alt"
    >}}
{{< /gallery/gallery >}}

{{< gallery/gallery
    caption="Screenshot der Kamera-App im Landschaftsmodus. Das Kamerabild ist verdreht und weiterhin hochkant ausgerichtet.9"
>}}
    {{< gallery/image
        src="/img/posts/librem_5/librem_5_screenshot_camera.webp"
        alt="alt"
    >}}
{{< /gallery/gallery >}}

### Terminal

Ein Terminalemulator ist vorinstalliert und verhält sich tadellos.
Man kann sich mit `sudo` Superuser-Rechte verschaffen und hat somit vollen Zugriff auf das System.
Das `sudo`-Passwort ist das selbe wie zum Bildschirm entsperren.
Hier zeigt sich besonders, dass man es mit einem echten, offenen Linux zu tun hat.
Die Bedienung mit der Onscreen-Tastatur ist zwar etwas umständlich
-- man muss ständig zwischen alphabetischem Layout und Terminal Layout wechseln --
das war bei diesem Formfaktor aber auch nicht anders zu erwarten.
Eine externe Tastatur hilft hier sehr und man kann nach Belieben rumhacken.

### Dateien

Der Datei-Explorer sieht GTK-typisch aus und verhält sich auch so.
Man kann gut navigieren und versteckte Dateien schnell ein- und ausblenden.
Tippt man eine Datei an, öffnet sich das für den Dateityp eingerichtete Standardprogramm.
Ein "kleines" Manko gibt es allerdings beim Kontextmenü: Es ist unbenutzbar.
Hält man etwa eine Sekunde auf ein Icon gedrückt, poppt das Menü zwar wunderbar auf,
jedoch ist mir nicht klar, wie man einen der Einträge auswählen soll.
Mit dem haltenden Finger über das Menü fahren macht nichts.
Den Finger loslassen, schließt das Menü wieder.
Mit einem zweiten Finger die Einträge auswählen funktioniert auch nicht.
Dateien bearbeitet man hier tatsächlich besser mit dem Terminal.

### Workstation Modus

Meine Erfahrung mit dem Workstation Modus war eher holprig.
Ich habe Maus und Tastatur an meinem BENQ UWQHD Monitor angeschlossen und diesen über USB-C an
einen Hub, welcher wiederum über USB-C normalerweise an meinem Laptop hängt.
Wenn ich das Librem statt des Laptops an den Hub hänge, funktionieren zwar Maus und Tastatur, aber
das Bild auf dem Monitor flackert stark.
Nach mehreren Malen ab- und wieder anstecken, flackert das Bild irgendwann nicht mehr und man kann
vernünftig arbeiten.
Sieht man von dem Geflacker ab, was wohl an meinem Hub liegt, funktioniert der Workstation-Modus
einwandfrei.
Schließe ich das Librem direkt per USB-C an den Monitor, wird letzterer leider nicht erkannt.
Ein 4K ACER Monitor, der über ein DP &#129062; USB-C Kabel angeschlossen war,
hat sofort ohne Flackern funktioniert.
Allerdings konnte ich dann keine Maus/Tastatur mehr verbinden,
da ich selbst keine Bluetooth-Peripherie besitze.

{{< youtube akg_mMYEugw >}}

### GPS

Das GPS lokalisiert mich etwa 10&nbsp;km zu weit südlich mit einer Ungenauigkeit von 5&nbsp;km.
Es scheint daher für die Navigation auf der Straße oder in der Stadt ziemlich unbrauchbar.
