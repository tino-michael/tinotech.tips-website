---
title: "Librem 5: Das open-source Linux-Telephon"
date: 2021-10-23T08:59:05+02:00
banner: "/img/posts/librem_5/librem_5_logo.webp"
authors: ["Tino Michael"]
categories: []
tags: ["librem", "pure_os", "privacy", "linux", "open_source"]
draft: true
summary: "Im Jahre 2017 wurde mit dem Librem 5 ein komplett Linux-basiertes open-source Smartphone angekündigt. Es sollte uns der Konvergenz zwischen mobilen und stationären Computern endlich näher bringen. Ob es diese Versprechen erfüllen kann, erfahrt ihr in diesem Beitrag."
---

Schon vor 10 Jahren fand ich es sehr nervig, mehrere Computer jonglieren zu müssen:
Der Desktop zu Hause, ein Laptop für die Arbeit und ein Smartphone für die Hosentasche.
Alle Geräte möchten auf dem neuesten Stand gehalten werden, Accounts eingerichtet und Daten
synchronisiert haben.
Ich hatte mir überlegt, wie toll es doch wäre, nur ein kleines Gerät zu haben, das man überall hin
mitnehmen kann, eigenständig funktioniert (also praktisch ein Handy) und bei Bedarf zu einem Tablet,
Laptop oder einer Workstation erweitert werden kann.
Dabei habe ich nicht an ein stumpfes Android gedacht, dessen Oberfläche auf einen großen Bildschirm
aufgeblasen wird, sondern an ein Betriebssystem, das nahtlos mit einer mobilen Oberfläche auf dem
kleinen Bildschirm und einer an externe Eingabegeräte (sprich: Tastatur und Maus) angepasste
Oberfläche auf dem großen Bildschirm umgehen kann.

Irgendwann bin ich auf Razer's [Project Linda](https://www.razer.com/concepts/project-linda) gestoßen:
Ein Smartphone, das an die Stelle des Touchpads in ein Laptop-Gehäuse gesteckt werden kann.
Der Laptop bringt neben Display und Tastatur noch erweiterten Speicher und Akkukapazität.
Man durfte also hoffen, auch wenn das Projekt nie über die Konzeptphase hinausgekommen zu sein scheint.

## Librem 5

In 2017 wurde ich auf die "Librem 5" Crowdfunding Kampagne der Firma [Purism](https://puri.sm)
aufmerksam.
Es wurde ein komplett Linux-basiertes open-source Smartphone versprochen, das über USB-C an Zusatzperipherie
angeschlossen werden kann und auf einem externen Monitor vertraute Desktop-Umgebungen anzeigt.
Ich war von der Vorstellung sehr angetan und hatte auch schon einen Laptop von der Firma
(einen Librem 13, welcher leider einem Regensturm zum Opfer gefallen ist...), somit habe ich ohne
lange zu zögern in die Kampagne investiert.
Mir war klar, dass ich damit nicht ein neues Smartphone kaufe, sondern in die Zukunft eines mobilen
Linux investiere.
Ich hatte also kein Problem damit, eine Weile auf mein Librem 5 zu warten.

{{< figure
    src="/img/posts/librem_5/Librem5LinuxDesktop-Monitor.jpg"
    caption="Librem 5 angeschlossen an externem Monitor, Maus und Tastatur. 3D-Rendering, das in der Crowdfunding Kampagne benutzt wurde. CC-by-SA 4.0 Purism."
    alt="Librem 5 angeschlossen an externem Monitor, Maus und Tastatur 3D-Rendering-Mockup"
>}}

## Ankunft und erster Eindruck

Sprung in den September 2021, ich möchte doch bitte meine Adresse bestätigen, mein Librem 5 wäre
zum Verschicken bereit.
Adresse bestätigt und ein paar Tage später lag das Librem 5 tatsächlich nach 4 Jahren vor mir auf
dem Tisch.
Beim ersten Mal in die Hand nehmen, wirkte das Telephon recht klobig und schwer.
Mit seinen 15&nbsp;mm ist es etwa doppelt so dick wie mein aktuelles Motorola g7.
Auch das mit 260&nbsp;g etwa 70&nbsp;g höhere Gewicht machen sich bemerkbar.
Entlang des rechten Randes liegen die üblichen Knöpfe für Power/Display und Lautstärke.
An der linken Seite liegt der Slot für SIM und SD-Karte und mehrere Schiebeschalter für die
Mobilverbindung, WLAN+Bluetooth und Kamera+Mikrophon.
Diese Schalter trennen mechanisch die Stromversorgung der entsprechenden Geräte, sodass man sich
wirklich sicher sein kann, dass die Funktionalität abgeschaltet ist und sich niemand durch Hacks
oder Software-Hintertüren doch Zugriff verschaffen kann.
Die Abdeckung auf der Rückseite kann entfernt werden und legt den wechselbaren Akku und den Slot
für eine Smartcard frei.
Auf der Oberseite befindet sich dann noch ein 3,5&nbsp;mm Kopfhöreranschluss.

{{< gallery/gallery
    class="gallery"
    caption="Librem 5 Smartphone: Schriftzug (links) und Hardwareschalter (rechts)"
>}}
{{< gallery/image
    src="/img/posts/librem_5/librem_5_logo.webp"
    alt="Librem 5 Schriftzug auf der Seite des Smartphones"
>}}
{{< gallery/image
    src="/img/posts/librem_5/librem_5_switches.webp"
    alt="Librem 5 Schiebeschalter auf der Seite des Smartphones"
>}}
{{< /gallery/gallery >}}

OK, also Powerknopf gedrückt halten und anschalten.
Die LED in der oberen rechten Ecke leuchtet auf, und ich werde nach einem Passwort für die
Verschlüsselung gefragt. Ich wusste nicht, dass eine Verschlüsselung bereits werksseitig aufgesetzt
wurde und so habe ich gedacht, das wäre eventuell das Verschlüsselungs-Setup und habe versucht,
ein eigenes Passwort zu setzen.
Das hat natürlich nicht geklappt; ein leeres Passwort auch nicht.
In der Kurzanleitung wurde erwähnt, dass das voreingestellte Passwort für die Bildschirmsperre
"123456" wäre. Damit wurde dann auch der Massenspeicher entsperrt.
Die Bestätigungsmeldung zeigt, dass hier `cryptsetup` zum Einsatz kommt.
Eine Änderung des Passwortes sollte später somit ohne Probleme möglich sein.
Nach wenigen Sekunden befinde ich mich im Hauptmenü von PureOS, dem Linux-Derivat, das auf dem
Librem seinen Dienst verrichtet.

Ich habe erst mal keine SIM-Karte eingelegt und mich nur in mein heimisches WLAN eingewählt.
Der PureOS Store hat auch gleich ein paar Updates vorgeschlagen.
Das Systemupdate lief eher Windows-typisch ab: Update herunterladen, neustarten, installieren und
wieder neustarten...

Die Menge der vorinstallierten Applikationen ist übersichtlich.
Es gibt eine mobil-typische Auflistung aller Installierten Apps mit einem reservierten Abschnitt
für die Favoriten.
Was auffällig fehlt, ist ein von Android bekanntes Home-Screen-Karussel, auf dem man Verknüpfungen
und Widgets -- etwa Uhr, Wetter, Kalender usw. -- verteilen kann.

In einem [Begleitartikel](../librem_5_begleitung) gehe ich mehr auf einzelne und kleinere Aspekte
ein, die mir während meiner ersten Woche Rumspielen aufgefallen sind.

## Convergence

Der Hauptverkaufspunkt des Librem 5 ist die sogenannte "Convergence", die Vereinheitlichung mobiler
und stationärer Betriebssysteme.
Es ist daher sehr viel Arbeit darin geflossen, die graphischen Oberflächen klassischer Desktopprogramme
"adaptiv" zu gestalten.
Das heißt, sie sollen sich auf kleineren Bildschirmen so umarrangieren, dass sie immer noch gut
bedienbar sind.
Für Webseiten existiert dieses Konzept schon seit ein paar Jahren und heißt dort "Responsive Design".
Ein anschauliches Beispiel für diesen Ansatz ist etwa das Einstellungsmenü.
Im Mobilmodus scrollt man wie gewohnt durch eine Liste an Menüpunkten,
sucht sich einen Punkt aus und tippt drauf.
Eine neue Ansicht mit den entsprechenden Einstellung füllt nun den Bildschirm aus.
Man muss auf einen "Zurück"-Knopf tippen um zum vorherigen Menü zurückzukehren.

{{< gallery/gallery
    class="gallery"
    caption="Verschiedene Screenshots vom Librem 5: Die App-Übersicht, das Einstellungsmenü und die Energieeinstellungen."
>}}
{{< gallery/image
    src="/img/posts/librem_5/librem_5_screenshot_menu.webp"
    alt="Librem 5"
>}}
{{< gallery/image
    src="/img/posts/librem_5/librem_5_screenshot_settings.webp"
    alt="Librem 5"
>}}
{{< gallery/image
    src="/img/posts/librem_5/librem_5_screenshot_settings_power.webp"
    alt="Librem 5"
>}}
{{< /gallery/gallery >}}

Führt man dasselbe Programm auf einem externen Monitor aus, ist die Auswahlliste des ursprünglichen
Menüs als Navigationsleiste am Fensterrand dargestellt und ausgewählte Punkte erscheinen im
übrigen Bereich des Fensters.

{{< figure
    src="/img/posts/librem_5/librem_5_screenshot_extended.webp"
    alt="Librem 5 Erweiterte Arbeitsfläche Extended Desktop"
    caption="Erweiterte Arbeitsfläche auf dem Librem 5. Der Bildschirm des Telephons ist oben links im Screenshot dargestellt. Die Hauptfläche des Bilder repräsentiert meinen externen Monitor."
>}}

Die Idee ist nicht, komplett neue graphische Oberflächen für den Mobilmodus zu erstellen, sondern
auf bestehenden Designs aufzubauen und diese zu motivieren, sich für kleinere Bildschirme anzupassen.
Das funktioniert schon erstaunlich gut.
Ab und zu findet man aber doch noch Programme oder einzelne Menüs, die nicht ganz auf den kleinen
Schirm passen und etwas über den Rand hinausragen.
Landet ein Knopf außerhalb des Bildschirms, ist dieser leider nicht mehr erreichbar.
Mit einer externen Maus (etwa über Bluetooth) könnte man das Fenster zur Seite schieben und
den restlichen Teil des Fensters doch noch erreichen.
Hier ist sicherlich noch einiges an Arbeit nötig und viele Programme müssen wohl per Hand angepasst
werden, damit sie sich gut in den kleineren Bildschirm einfügen.

## Librem 5 im Alltag

Ein weiterer Fokus des Librem Projektes ist die Respektierung der Freiheit und Privatsphäre der Benutzer.
Das heißt, dass quelloffene Software, Firmware und sogar Hardware zum Einsatz kommt, wo es irgend geht.
Es heißt aber auch, dass an vielen Stellen mangels offener Treiber nicht die performanteste
Hardware zur Verfügung steht.
Beim Librem 5 muss man definitiv Abstriche bei der Kamera, Batteriekapazität und Rechenleistung
hinnehmen.
Die Kamera reicht für gelegentliche Schnappschüsse bei guten Lichtverhältnissen.
Auf sie gehe ich in meinem [Begleitartikel](../librem_5_begleitung) etwas näher ein.
Die Batterie reicht selbst bei geringer Benutzung nur etwa einen halben Tag.
Man muss also regelmäßig daran denken, das Telephon zu laden oder bei Nichtbenutzung auszuschalten.
Die Rechenleistung reicht auf jeden Fall um Textdateien zu editieren, E-Mails zu schreiben und
Videos zu gucken, auch wenn das Interface teilweise etwas träge reagiert.
(Ich habe aber auch schon noch langsamere Android-Handys erlebt.)

## Schlusswort

Ich kann mir sehr gut vorstellen, dass das Librem 5 für Leute, die viel beruflich reisen, eine
leichtgewichtige Option ist, bequem ihre Präsentationen mitzubringen oder von unterwegs ihren Code
zu bearbeiten.
Zwar wird es für mich in seiner jetzigen Form so bald weder meinen Laptop noch mein Android Handy
ersetzen.
Jedoch sehe ich das Librem 5 als einen großen und wichtigen Schritt in die richtige Richtung hin zu
einer "konvergierenden Software-Landschaft".
Für Leute, die kompromisslos auf Open-Source bzw. Privatsphäre setzen wollen oder müssen,
ist das Librem 5 von Purism auf jeden Fall jetzt schon einen Blick wert.
