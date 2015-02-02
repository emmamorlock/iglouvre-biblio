<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">

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

    <!-- +++++++++++++++++++++ éléments non affichés -->
    <xsl:template match="idno"/>
    <xsl:template match="tei:respStmt/tei:resp"/>
    <!-- ++++++++++++++++++++ -->

    <!-- +++++++++++++++++++++ Structure de la page -->
    <xsl:template match="tei:TEI">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
                <link rel="stylesheet" type="text/css" media="screen, projection" href="theores.css"/>
            </head>
            <xsl:apply-templates select="//tei:listBibl"/>
        </html>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <body>
            <div class="bibl">
                <ul>
                    <xsl:for-each select="tei:biblStruct">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </ul>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="tei:biblStruct">
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:apply-templates select="tei:monogr[1]"/>
                    <xsl:if test="series">
                        <xsl:call-template name="series"/>
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                    <xsl:call-template name="publicationDate"/>
                    <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@type"/>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>

    <!-- +++++++++++++++++++++ Templates nommés -->

    <xsl:template name="creators">
        <xsl:for-each select="tei:author|tei:editor|tei:respStmt">

            <xsl:variable name="string">
                <xsl:apply-templates/>
            </xsl:variable>

            <xsl:choose>
                
                <!-- contributor role implies text before name -->                
                <xsl:when test="tei:resp = 'contributor'">
                    <xsl:text> (avec </xsl:text>
                    <xsl:value-of select="normalize-space($string)"/>
                    <xsl:text>)</xsl:text>
                    
                    <!-- 'and' or 'comma' separator -->
                    <xsl:choose>
                        <xsl:when test="following-sibling::tei:respStmt/tei:resp = 'contributor'"/>
                        <xsl:when test="count(following-sibling::tei:*/tei:surname/text()) = 1 or count(following-sibling::tei:*/tei:name/text()) = 1 or count(following-sibling::tei:*/tei:persName/tei:surname/text()) = 1">
                            <xsl:text> et </xsl:text>
                        </xsl:when>
                        <xsl:when test="count(following-sibling::tei:*/tei:surname/text()) != 0 or count(following-sibling::tei:*/tei:name/text()) != 0 or count(following-sibling::tei:*/tei:persName/tei:surname/text()) != 0">
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
               
                <xsl:otherwise>                  
                                          
                    <xsl:variable name="role">
                        <xsl:choose>
                            <xsl:when test="@role ='scientificEditor'or @role = 'editor'">
                                <xsl:text> (ed.)</xsl:text>
                            </xsl:when>                           
                            <xsl:when test="@role ='seriesEditor'">
                                <xsl:text> (dir.)</xsl:text>
                            </xsl:when>                            
                            <xsl:when test="contains(.,'translator')">
                                <xsl:text> (trad.)</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:value-of select="normalize-space(concat($string, ' ', $role))"/>
                    
                   
                    
                    <!-- 'and' or 'comma' separator -->
                    <xsl:choose>
                        <xsl:when test="following-sibling::tei:respStmt/tei:resp = 'contributor'"/>
                        <xsl:when test="count(following-sibling::tei:*/tei:surname/text()) = 1 or count(following-sibling::tei:*/tei:name/text()) = 1 or count(following-sibling::tei:*/tei:persName/tei:surname/text()) = 1">
                            <xsl:text> et </xsl:text>
                        </xsl:when>
                        <xsl:when test="count(following-sibling::tei:*/tei:surname/text()) != 0 or count(following-sibling::tei:*/tei:name/text()) != 0 or count(following-sibling::tei:*/tei:persName/tei:surname/text()) != 0">
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                        
                    </xsl:choose>
                    
                  <!-- 
                    <xsl:if test="not(position()=last())">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                 
                    <xsl:if test="position()=last()">
                        <xsl:value-of select="concat($role,', ')"/>
                    </xsl:if>
              -->
                    
                   
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="series">
        <span class="title">
            <xsl:value-of select="../tei:series/tei:title"/>
        </span>
        <xsl:text> </xsl:text>
        <xsl:if test="../tei:series/tei:biblScope">
            <xsl:value-of select="../tei:series/tei:biblScope"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="title">
        <xsl:param name="titleType"/>
        <span class="title">
            <xsl:choose>
                <xsl:when test="$titleType = 'short'">
                    <xsl:value-of select="normalize-space(tei:title[@type='short'])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space(tei:title[not(@type)])"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template name="publicationDate">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="tei:imprint/tei:date/@when"/>
    </xsl:template>



    <!--  template match -->

    <xsl:template match="tei:author">
        <span class="author">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:series/tei:biblScope">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="tei:biblScope">
        <xsl:if test="@unit">
            <xsl:value-of select="concat(@unit,'.')"/>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template name="date">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:editor">
        <span class="editor">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:forename">
        <xsl:value-of select="concat(substring(.,1,1),'. ')"/>
    </xsl:template>

    <xsl:template match="tei:monogr[1]">
        <xsl:call-template name="creators"/>
        <xsl:text> </xsl:text>
        <xsl:call-template name="title">
            <xsl:with-param name="titleType">
                <!-- select short title if exists -->
                <xsl:if test="tei:title[@type='short']">
                    <xsl:text>short</xsl:text>
                </xsl:if>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:if test="../tei:series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->
    </xsl:template>


    <xsl:template match="tei:monogr[2]">
        <!-- titre ensemble -->
        <xsl:if test="tei:monogr[2]">
            <span class="titreEnsemble">
                <xsl:apply-templates select="title"/>
            </span>
        </xsl:if>
    </xsl:template>





    <xsl:template match="tei:series">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:surname">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
