<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl tei html">
    <xsl:import href="iglouvre-biblio-commun.xsl"/>
    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
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
    <!-- +++++++++++++++++++++ paramètres -->
    <xsl:param name="tri"/>
    <xsl:param name="in">
        <xsl:text>in </xsl:text>
    </xsl:param>
    <!-- +++++++++++++++++++++ Structure de la page -->
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <style type="text/css"> 
                    <xsl:comment>
                    <![CDATA[ 
                    body{
                        font-family:Verdana, Arial, Helvetica, sans-serif;
                        font-size:14px;
                    }
                    table{
                        border-collapse:collapse;
                        border-spacing:2px;
                        border-color:gray;
                        width:95%;
                    }
                    th{
                        height:50px;
                    }
                    table,
                    th,
                    td{
                        border:1px solid #98bf21;
                        font-family:'times new roman', sans-serif;
                    }
                    td{
                        text-align:left;
                        font-size:90%;
                        padding:3px 7px 2px 7px;
                    }
                    td{
                        height:50px;
                        vertical-align:bottom;
                    }
                    td.note{
                        word-wrap:break-word;
                        overflow:hidden;
                        font-size:.75em;
                    }
                    td.00{
                        white-space:pre-wrap;
                        color:silver;
                        font-family:"Lucida Console";
                    }
                    td.0b{
                        width:50%;
                    }
                    thead{
                        font-weight:bold;
                    }
                    tr:nth-child(odd){
                        background-color:#EAF2D3;
                    }
                    tr:nth-child(even){
                        background-color:white;
                    }
                    span.resp:nth-child(odd){
                        display:block;
                        color:maroon;
                    }
                    span.resp:nth-child(even){
                        display:block;
                        color:green;
                    }
                    span.role{
                        font-size:75%;
                    }
                    span.title{
                        font-style:italic;
                    }
                    span.title > span.title{
                        font-style:normal;
                    }
                     span.s {
                        font-style:normal;
                    }
                     span.ensemble{
                        color:red;
                    }
                    span.test{
                        color:silver;
                    }
                    .titre-ensemble {color:red;}
                    ]]>
                    </xsl:comment>
                        
                    
                </style>
            </head>
            <body>
                <h1>IGLouvre - Biblio - Contrôle</h1>
                <p>Date : <xsl:value-of select="current-dateTime()"/></p>
                <xsl:for-each-group select="//tei:biblStruct" group-by="@type">
                    <h2>Type Zotero : <xsl:value-of select="current-grouping-key()"/></h2>
                    <table>
                        <thead>
                            <tr>
                                <td>Code TEI</td>
                                <td class="0a">ref. bibl. abrégée</td>
                                <td class="0b">ref. bibl complète</td>
                                <td class="note">Note</td>
                                <td class="10">Lien vers Zot.</td>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- tri par ref. abrégée / date publication, asc -->
                            <!--  
                                <xsl:sort select="tei:monogr/tei:title[@type='short']"/>
                                <xsl:sort select="tei:monogr/tei:imprint/tei:date/@when"/>
                            -->
                            <!-- tri par titre d'ensemble / titre / date publication asc -->
                            <!--  
                            <xsl:sort select="tei:monogr[2]"/>
                            <xsl:sort select="tei:monogr/tei:title[@type='short']"/>
                            <xsl:sort select="tei:monogr/tei:imprint/tei:date/@when"/>
                            -->
                            <xsl:for-each select="current-group()">
                                <xsl:sort select="tei:monogr[2]"/>
                                <xsl:sort select="tei:monogr/tei:title[@type='short'][1]"/>
                                <xsl:sort select="tei:monogr/tei:imprint/tei:date/@when"/>
                                <xsl:call-template name="tr"/>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </xsl:for-each-group>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="tr">
        <tr>
            <td class="00">
                <xsl:apply-templates mode="codeXML"/>
            </td>
            <td class="0a">
                <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
            </td>
            <td class="0b">
                <xsl:variable name="maintxt">
                    <xsl:apply-templates select="."/>
                </xsl:variable>
                <xsl:variable name="maintxt2">
                    <xsl:apply-templates select="$maintxt" mode="zoteroItalics"/>
                </xsl:variable>
                <xsl:apply-templates select="$maintxt2" mode="zoteroItalics"/>
            </td>
            <td class="note">
                <xsl:apply-templates select="tei:note"/>
            </td>
            <td class="10">
                <xsl:apply-templates select="tei:idno[@type='zotero-uri']"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="tei:biblStruct[@type='book']">
        <!-- createurs -->
        <!-- on traite d'abord les auteurs / editeurs  -->
        <xsl:if test="tei:monogr[1]/tei:author or tei:monogr[1]/tei:editor or tei:monogr[1]/tei:respStmt">
            <xsl:for-each select="tei:monogr[1]/tei:author|tei:monogr[1]/tei:editor">
                <xsl:call-template name="makeCreator">
                    <xsl:with-param name="creator">
                        <xsl:sequence select="."/>
                    </xsl:with-param>
                    <xsl:with-param name="separator">
                        <xsl:choose>
                            <xsl:when test="position() = last()"/>
                            <xsl:when test="position() = last()-1">
                                <xsl:text> et </xsl:text>
                            </xsl:when>
                            <xsl:when test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <!-- on traite ensuite les contributeurs  -->
            <xsl:for-each-group select="tei:monogr[1]/tei:respStmt" group-by="tei:resp">
                <xsl:text> (</xsl:text>
                <xsl:choose>
                    <xsl:when test="current-grouping-key() ='translator'">
                        <xsl:text>trad. </xsl:text>
                    </xsl:when>
                    <xsl:when test="current-grouping-key() ='contributor'">
                        <xsl:text>avec </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:for-each select="current-group()">
                    <xsl:apply-templates select="."/>
                    <xsl:choose>
                        <xsl:when test="position() = last()"/>
                        <xsl:when test="position() = last()-1">
                            <xsl:text> et </xsl:text>
                        </xsl:when>
                        <xsl:when test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
            </xsl:for-each-group>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- titre d'ensemble -->
        <xsl:if test="tei:monogr[2]">
            <xsl:apply-templates select="tei:monogr[2]/tei:title[@level='m']"/>
            <!-- separateur -->
            <xsl:text>. </xsl:text>
            <!-- numero du volume -->
            <xsl:apply-templates select="tei:monogr[2]/tei:biblScope[@unit='volume']"/>
        </xsl:if>
        <!-- edition -->
        <xsl:if test="tei:monogr[1]/tei:edition">
            <!-- separateur -->
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:edition"/>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- titre du volume -->
        <xsl:if test="tei:monogr[1]/tei:title[@level='m']">
            <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- collection -->
        <xsl:if test="tei:series">
            <xsl:apply-templates select="tei:series"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- date de publication -->
        <xsl:apply-templates select="tei:monogr[1]/tei:imprint/tei:date"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
        <!-- pas compris ? extent ? -->
    </xsl:template>
    <xsl:template match="tei:biblStruct[@type='bookSection']">
        <!-- s'il y a article -->
        <xsl:if test="tei:analytic">
            <!-- auteur(s) de l'article -->
            <xsl:for-each select="tei:analytic/tei:author">
                <xsl:call-template name="makeCreator">
                    <xsl:with-param name="creator">
                        <xsl:sequence select="."/>
                    </xsl:with-param>
                    <xsl:with-param name="separator">
                        <xsl:choose>
                            <xsl:when test="position() = last()"/>
                            <xsl:when test="position() = last()-1">
                                <xsl:text> et </xsl:text>
                            </xsl:when>
                            <xsl:when test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <!-- titre de l'article -->
            <xsl:text> &#171; </xsl:text>
            <xsl:apply-templates select="tei:analytic/tei:title[@level='a']"/>
            <xsl:text> &#187; </xsl:text>
            <!-- in -->
            <xsl:value-of select="$in"/>
        </xsl:if>
        <!-- createurs -->
        <!-- on traite d'abord les auteurs / editeurs  -->
        <xsl:if test="tei:monogr[1]/tei:author or tei:monogr[1]/tei:editor or tei:monogr[1]/tei:respStmt">
            <xsl:for-each select="tei:monogr[1]/tei:author|tei:monogr[1]/tei:editor">
                <xsl:call-template name="makeCreator">
                    <xsl:with-param name="creator">
                        <xsl:sequence select="."/>
                    </xsl:with-param>
                    <xsl:with-param name="separator">
                        <xsl:choose>
                            <xsl:when test="position() = last()"/>
                            <xsl:when test="position() = last()-1">
                                <xsl:text> et </xsl:text>
                            </xsl:when>
                            <xsl:when test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <!-- on traite ensuite les contributeurs  -->
            <xsl:for-each-group select="tei:monogr[1]/tei:respStmt" group-by="tei:resp">
                <xsl:text> (</xsl:text>
                <xsl:choose>
                    <xsl:when test="current-grouping-key() ='translator'">
                        <xsl:text>trad. </xsl:text>
                    </xsl:when>
                    <xsl:when test="current-grouping-key() ='contributor'">
                        <xsl:text>avec </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:for-each select="current-group()">
                    <xsl:apply-templates select="."/>
                    <xsl:choose>
                        <xsl:when test="position() = last()"/>
                        <xsl:when test="position() = last()-1">
                            <xsl:text> et </xsl:text>
                        </xsl:when>
                        <xsl:when test="position() != last()">
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
            </xsl:for-each-group>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- titre d'ensemble -->
        <xsl:if test="tei:monogr[2]">
            <xsl:apply-templates select="tei:monogr[2]/tei:title[@level='m']"/>
            <!-- separateur -->
            <xsl:text>. </xsl:text>
            <!-- numero du volume -->
            <xsl:apply-templates select="tei:monogr[2]/tei:biblScope[@unit='volume']"/>
        </xsl:if>
        <!-- edition -->
        <xsl:if test="tei:monogr[1]/tei:edition">
            <!-- separateur -->
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:edition"/>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- titre du volume -->
        <xsl:if test="tei:monogr[1]/tei:title[@level='m']">
            <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- collection -->
        <xsl:if test="tei:series">
            <xsl:apply-templates select="tei:series"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- date de publication -->
        <xsl:apply-templates select="tei:monogr[1]/tei:imprint/tei:date"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
        <!-- pas compris ? extent ? -->
    </xsl:template>
    <xsl:template match="tei:biblStruct[@type='book']" mode="shortRef">
        <!-- affiche la référence abrégée avec la référence longue au survol -->
        <!-- à revoir -->
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:variable name="id" select="@xml:id"/>
                    <xsl:variable name="linkUri" select="tei:idno[@type='zotero-uri']"/>
                    <xsl:variable name="longRef">
                        <xsl:apply-templates select="tei:monogr[1]"/>
                        <xsl:if test="tei:series">
                            <xsl:apply-templates select="tei:series"/>
                            <xsl:text>,</xsl:text>
                        </xsl:if>
                        <!-- ajouter publication date -->
                    </xsl:variable>
                    <!--  <xsl:variable name="test" select="translate(normalize-unicode($longRef),'áàâäéèêëíìîïóòôöúùûü','aaaaeeeeiiiioooouuuu')"/>-->
                    <span class="shortRef">
                        <a href="{$linkUri}" title="{$longRef}">
                            <xsl:value-of select="tei:monogr[1]/tei:title[@type='short']"/>
                        </a>
                    </span>
                </xsl:when>
            </xsl:choose>
        </li>
    </xsl:template>
    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- templates de surcharge de iglouvre-biblio-commun.xsl -->
    <xsl:template match="tei:forename">
        <xsl:value-of select="concat(upper-case(substring(.,1,1)),'. ')"/>
    </xsl:template>
</xsl:stylesheet>
