<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">
    <xsl:import href="iglouvre-biblio-commun.xsl"/>
    <!-- todo : traitement des forename : tokenize  -->
    <!-- todo : traitement des forename  : autres alphabets-->
    <!-- todo : nombre de volumes -->

    <!-- 
    MONOGAPHIES
    [Créateur], [Titre. Sous-titre], [Titre de la collection]* [numéro dans la collection]**, [date de publication], [nombre de volumes].
    É. Samama, Les médecins dans le monde grec. Sources épigraphiques sur la naissance d’un corps médical, Hautes études du monde romain 31, 2003.
    
    CONTRIBUTIONS A DES OUVRAGES
    [Auteur], « [Titre de l’article] », in [Créateur], [Titre de l’ouvrage. Sous-titre de l’ouvrage], [édition], [Titre de la collection]* [numéro dans la collection] **, [date de publication], [localisation].
    N. Massar, « Choix d’inscriptions. La profession médicale dans l’épigraphie », in A. Verbanck-Piérard (éd.), Au temps d’Hippocrate. Médecine et société en Grèce antique, 1998, p. 83-97.
 
    CONTRIBUTION A DES ACTES DE COLLOQUES 
    [Auteur], « [Titre de l’article] », in [Créateur] (éd.), [Titre de l’ouvrage. Sous-titre de l’ouvrage], [intitulé du colloque]*, [édition], [Titre de la collection]** [numéro dans la collection]***, [date de publication], [localisation].
 
    ARTICLE DE PERIODIQUE
    [Auteur], « [Titre de l’article] », [Titre du périodique abrégé s’il existe] [volume du périodique]/[numéro du périodique], [date de publication], [localisation].
    
    ARTICLE DE DICTIONNAIRE 
    [Auteur], s.v. «  [Titre de l’article de dictionnaire ou d’encyclopédie] », [Titre court du dictionnaire ou de l’encyclopédie], [date de publication], [localisation].
 
    CAS AVEC TITRE D ENSEMBLE
    
    a: Cas d’un article (type Zotero chapitre d’ouvrage) paru dans un volume faisant partie d’un ensemble.
    [Auteur], « [Titre de l’article] », in [Editeur scientifique] et [Editeur scientifique] (ed.), [Titre d’ensemble]. [numéro du volume], [Titre du volume], [date de publication], [localisation].
    F. Blass, « Die kretischen Inschriften », in H. Collitz et F. Bechtel (éd.), Sammlung der griechischen Dialekt-Inschriften. III, 2, Die Inschriften der dorischen Gebiete ausser Lakonien, Thera, Melos, Kreta, Sicilien, 1905, p. 227-423.
 
    b: 
    [éditeur scientifique] et [éditeur scientifique] (éd.), [Titre d’ensemble]. [numéro de volume], [Titre du volume],[date de publication].
    M. Guarducci et F. Halbherr (éd.), Inscriptiones creticae. I, Tituli Cretae mediae praeter Gortynios, 1935.


exemples à faire
- 1 auteur et deux éditeurs scientifiques
- 1 auteur, 1 traducteur et 2 éditeurs scientifiques


 -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>


    <!-- +++++++++++++++++++++ Structure de la page -->
    
    
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            </head>
            <xsl:apply-templates select="//tei:listBibl"/>
        </html>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <body>
            <div class="bibl">
                <ul>
                    <xsl:for-each select="tei:biblStruct[@type='book']">
                        <li>
                            <xsl:apply-templates select="." mode="longRef"/>
                        </li>
                    </xsl:for-each>

                </ul>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="tei:biblStruct" mode="longRef">
        <!-- affiche la référence longue avec la référence abrégée au survol -->
        <xsl:apply-templates select="tei:monogr[1]" mode="longRef"/>
        <xsl:if test="series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
    </xsl:template>

    <xsl:template match="tei:biblStruct" mode="shortRef">
        <!-- affiche la référence abrégée avec la référence longue au survol -->
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:variable name="id" select="@xml:id"/>
                    <xsl:variable name="linkUri" select="tei:idno[@type='zotero-uri']"/>
                    <xsl:variable name="longRef">
                        <xsl:apply-templates select="tei:monogr[1]"/>
                        <xsl:if test="series">
                            <xsl:call-template name="series"/>
                            <xsl:text>,</xsl:text>
                        </xsl:if>
                        <xsl:call-template name="publicationDate"/>
                    </xsl:variable>
                    <!--  <xsl:variable name="test" select="translate(normalize-unicode($longRef),'áàâäéèêëíìîïóòôöúùûü','aaaaeeeeiiiioooouuuu')"/>-->
                    <span class="shortRef">
                        <a href="{$linkUri}" title="{$longRef}">
                            <xsl:value-of select="tei:monogr/tei:title[@type='short']"/>
                        </a>
                    </span>
                </xsl:when>
            </xsl:choose>
        </li>
    </xsl:template>


   

</xsl:stylesheet>
