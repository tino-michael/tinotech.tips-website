---
title: "Bewerbungsunterlagen super einfach organisieren mit git und Latex"
date: 2021-10-09T10:00:00+02:00
authors: ["Tino Michael"]
tags: ["latex", "git", "resume"]
summary: "Da Lebenslauf und Anschreiben für jede Bewerbung angepasst werden, kommt man schnell in Versuchung, Kopien seiner Dateien anzulegen und diese mit Versionsnummern, Firmennamen oder dem berühmt berüchtigtem \"final\" zu versehen. Wenn dann noch im Laufe der Zeit neue Erfahrungen und Fähigkeiten eingebaut werden sollen, ist
es mit der Übersicht schnell dahin. Damit das Chaos keine Chance hat, überhand zu nehmen, sollte man sich am besten gleich zu Beginn
ein gutes System überlegen, die verschiedenen Versionen der Dateien zu organisieren."

---

Gerade in Corona-Zeiten guckt sich manch einer nach einem neuen Job um.
Aber auch danach werden die meisten nicht darum herum kommen, ab und zu einen Schwung Bewerbungen
zu verschicken.
Da Lebenslauf und Anschreiben für jede Bewerbung angepasst werden, kommt man schnell in Versuchung,
Kopien seiner Dateien anzulegen und diese mit Versionsnummern, Firmennamen oder dem
berühmt berüchtigtem "final" (ganz zu schweigen vom "final_final") zu versehen.
Wenn dann noch im Laufe der Zeit neue Erfahrungen und Fähigkeiten eingebaut werden sollen, ist
es mit der Übersicht schnell dahin.

{{< figure src="/img/posts/resume_git_latex/cv_unorder.webp"
    caption="Zu viele Kopien: Die Übersicht geht schnell verloren"
    alt="Lebensläufe Unübersicht">}}

## Die Übersicht behalten

Damit das Chaos keine Chance hat, überhand zu nehmen, sollte man sich am besten gleich zu Beginn
ein gutes System überlegen, die verschiedenen Versionen der Dateien zu organisieren.
Das System, das ich mir im Laufe der Zeit erarbeitet habe, basiert darauf, Lebenslauf und Anschreiben
in Latex zu verfassen und mit git zu versionieren.

Natürlich kann man statt Latex ein beliebiges anderes Format benutzen, welches auf einfachen
Textdateien basiert; wie etwa Markdown oder auch HTML.
Hauptsache am Ende kommen anschauliche Bewerbungsunterlagen dabei heraus.
Dateiformate wie die von LibreOffice oder anderen Office-Paketen funktionieren prinzipiell auch,
jedoch ist git für diese nicht optimiert und ich rate von ihnen eher ab.

Die Grundversionen der Dokumente leben im `master`-Branch.
Wenn Informationen hinzugefügt oder Sätze umformuliert werden, gibt es einen neuen Commit.
So hat man immer Zugriff auf ältere Versionen derselben Dateien und ist nicht auf eine Vielzahl an
Kopien angewiesen, die alle nebeneinander liegen.
Hat man eine interessante Stellenausschreibung gefunden, wird für die Firma ein dedizierter Branch
angelegt. Hier kann man nun Kontaktdaten der Firma einpflegen und die eigenen Angaben auf die Stelle
anpassen, ohne damit den `master`-Branch zu "verschmutzen".
Firmen-spezifische Informationen landen immer im entsprechenden Branch und nie im `master`.
So verhindert man effektiv solche Peinlichkeiten wie das Ansprechen der falschen Kontaktperson oder
zu unterstreichen, wie gut man doch in die **falsche** Firma passt.
Die finale Version wird mit einem Commit in das Repository geschrieben.
So hat man später für das Interview sofort dieselbe Version wie der Gesprächspartner parat.

## Schritt für Schritt

Wenn ich euer Interesse geweckt habe, es in dem Abschnitt gerade aber etwas zu schnell zuging,
habe ich hier eine ausführliche Erklärung zusammengestellt, mit der ihr Schritt für Schritt eine
eigene Versionskontrolle für euren Lebenslauf aufsetzen könnt.

Dies soll allerdings keine Einleitung für git oder Latex darstellen.
Ich gebe die meisten Befehle, die ich benutze, hier mit an, jedoch gehe ich davon aus,
dass ihr git zumindest schon mal über den Weg gelaufen seid.

### Latex Setup

Wer seinen Lebenslauf noch nicht als Latex-Dokument angelegt hat und es mal ausprobieren möchte,
kann sich gerne meine [Templates](https://github.com/tino-michael/latex/tree/main/templates/job_application)
und [Style Files](https://github.com/tino-michael/latex/tree/main/styles) angucken.
Legt euch einen neuen Ordner für eure Bewerbungsunterlagen an und ladet `cover_letter.tex` und
`resume.tex` in diesen Ordner herunter.
Die Namen dieser Dateien könnt ihr gerne ändern, um etwa noch euren eigenen Namen zu enthalten.
Von den Styles werden `standardsetup.sty` und `application.sty` benötigt.
Diese Styles könnt ihr entweder systemweit installiert oder einfach in dem selben Ordner wie
die `.tex`-Dateien ablegen.
Ganz einfach geht das zum Beispiel mit `wget`:

```bash
wget \
https://raw.githubusercontent.com/tino-michael/latex/master/templates/job_application/cover_letter.tex \
https://raw.githubusercontent.com/tino-michael/latex/master/templates/job_application/resume.tex \
https://raw.githubusercontent.com/tino-michael/latex/master/styles/application.sty \
https://raw.githubusercontent.com/tino-michael/latex/master/styles/standardsetup.sty
```

Das Ganze könnte dann wie folgt aussehen:

{{< figure src="/img/posts/resume_git_latex/cv_tex.webp"
    caption="Latex-Dateien für Lebenslauf und Anschreiben"
    alt="Lebenslauf und Anschreiben mit Latex">}}

### git Setup

Als nächstes legt ihr ein git-Repository in dem Ordner an, in den ihr die Dateien heruntergeladen
habt, und fügt alle Dateien in den initialen Commit hinzu.
Vorher können Lebenslauf und Anschreiben natürlich schon etwas befüllt werden.

```bash
git init .
git add *sty *tex
git commit -m "initialer Commit"
```

Zur Visualisierung der Historie unseres git-Repos benutze ich den open-source editor
*Visual Studio Code* mit dem *Git Graph* Plugin:

{{< figure src="/img/posts/resume_git_latex/vscode_initial_commit_cropped.webp"
    caption=""
    alt="Visual Studio Code git initial commit">}}

Jetzt könnt ihr euch die Zeit nehmen um euren Lebenslauf und Anschreiben noch einmal ordentlich
aufzupolieren. Einzelne Updates, wenn ihr etwa eine Berufserfahrung hinzufügt oder einen Satz
umformuliert, sollten in eigenen Commits verewigt werden.
Alle Änderungen könnt ihr jederzeit in der Branch-Übersicht des Repositories nachverfolgen.

{{< figure src="/img/posts/resume_git_latex/vscode_more_commits_cropped.webp"
    caption=""
    alt="Visual Studio Code git commit history">}}

### Für Bewerbung Branch anlegen

Wenn ihr eine Stellenausschreibung gefunden habt, auf die ihr euch bewerben möchtet, legt für die
entsprechende Firma einen neuen Branch an (und wechselt sofort dorthin):

```bash
git checkout -b Firma_1
```

Hier könnt ihr Adresse und Ansprechpartner der Firma einpflegen und eure Unterlagen genau auf die
ausgeschriebene Stelle anpassen.
Wenn ihr mit euren Änderungen zufrieden seid, fixiert die Version, mit der ihr die Bewerbung
abschicken möchtet in einem weiteren Commit.
Somit könnt ihr jederzeit, wenn es nötig sein sollte, zu diesem Stand zurückkehren.

{{< figure src="/img/posts/resume_git_latex/vscode_firma_1_cropped.webp"
    caption=""
    alt="Visual Studio Code git commit history">}}

Falls ihr euch zeitgleich bei einer weiteren Firma auf eine Stelle bewerben möchtet,
erzeugt einfach einen weiteren Branch vom `master` aus:

```bash
git checkout -b Firma_2 master
```

und passt alles an wie für die vorherige Ausschreibung.

Wenn ihr etwas Neues gelernt habt und dies in eurem Lebenslauf erwähnen möchtet, geht zurück zum
`master`-Branch und tragt es dort mit einem neuen Commit ein. Der Stand der anderen Bewerbungs-Branches
bleibt davon unberührt und ihr bekommt eine übersichtliche Zusammenfassung der verschiedenen
Versionen eurer Dokumente.

{{< figure src="/img/posts/resume_git_latex/vscode_master_update_cropped.webp"
    caption=""
    alt="Visual Studio Code git commit history">}}

Solltet ihr eine Version irgendwann tatsächlich nicht mehr brauchen, löscht einfach den Branch aus
dem Repository und die Historie des gesamten Zweiges verschwindet wieder:

```bash
git branch -D Firma_2
```

## Schlusswort

Da ich eine Zeit in der Wissenschaft auf befristeten Stellen gearbeitet habe und auch viel umgezogen
bin, fand ich mich immer wieder in mehr oder weniger langen Bewerbungsphasen.
Während dieser Zeiten habe ich das hier vorgestellte System entwickelt und es hat mir sehr geholfen,
den Überblick über meine Bewerbungen zu behalten.
Es würde mich freuen, wenn es dem ein oder anderen Leser da draußen einen Anreiz gibt, es auch mal
auszuprobieren und Ordnung in das Bewerbungschaos zu bringen.
