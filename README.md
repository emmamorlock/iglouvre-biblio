# IGLouvre-biblio

Dossier de travail du projet IGLouvre : export et contrôle qualité des données
----------------------------------------------------------------------------------------------

Ce dossier contient :
- un translator Zotero (TEI-iglouvre.js) pour l'export des donnéees
- un jeu de feuilles de styles XSL pour la transformation des données bibiliographiques dans les différentes formes html utilisées pour le projet (iglouvre-biblio-controle.xsl et iglouvre-biblio-commun.xsl)

Etapes recommandées :

1. Installation du fichier TEI-iglouvre.js dans le dossier "translator" de votre installation de Zotero standalone
2. Copier le dossier XSL sur un dossier de votre disque dur
3. Exporter les données bibliographiques depuis zotero-standalone au format TEI, en utilisant le translator "TEI-iglouvre.js" (sélectionner les fiches Zotero qui vous intéressent, faire un clic-droit pour accéder au menu "Exporter" puis sélectionner le format d'export "TEI-iglouvre"
4. Ouvre le fichier TEI/XML ainsi exporté avec Oxygen
5. Créez un scénario de transformation (cf. http://www.oxygenxml.com/demo/Validation_Scenario.html) en pointant sur iglouvre-biblio-controle.xsl) et en utilisant le processeur Saxon HE...


--------
--------
Cf. https://www.zotero.org/support/dev/translators/functions



