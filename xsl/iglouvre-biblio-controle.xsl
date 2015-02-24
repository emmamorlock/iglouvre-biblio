<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">
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
                     span.ensemble{
                        color:red;
                    }
                    span.test{
                        color:silver;
                    }
                    ]]>
                    </xsl:comment>
                        
                    
                </style>

            </head>
            <body>
                <h1>IGLouvre - Biblio - Contrôle</h1>
                <h2>Monographies (type Zotero "book") </h2>
                <p>Date : <xsl:value-of select="current-dateTime()"/></p>

                <table>
                    <thead>
                        <tr>
                            <td class="0a">ref. bibl. abrégée</td>
                            <td class="0b">ref. bibl complète</td>
                            <!-- <td class="note">Note</td> -->
                            <td class="10">Lien</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//tei:biblStruct[@type='book']">
                            <!-- tri par ref. abrégée / date publication, asc -->
                            <!--  
                                <xsl:sort select="tei:monogr/tei:title[@type='short']"/>
                                <xsl:sort select="tei:monogr/tei:imprint/tei:date/@when"/>
                            -->
                            <!-- tri par titre d'ensemble / titre / date publication asc -->
                            <!--  -->

                            <xsl:sort select="tei:monogr[2]"/>
                            <xsl:sort select="tei:monogr/tei:title[@type='short']"/>
                            
                            <xsl:sort select="tei:monogr/tei:imprint/tei:date/@when"/>
                            
                            <tr>                           
                                <xsl:choose>
                                    <xsl:when test="tei:monogr[2]">                                        
                                        <xsl:call-template name="table-td-ensemble"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="table-td"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tr>  
                            
                        </xsl:for-each>
                    </tbody>
                </table>

            </body>
        </html>
    </xsl:template>

    <!-- <xsl:apply-templates select="//tei:biblStruct" mode="longRef"/> -->


    <xsl:template name="table-td">
        <td class="0a">
            <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
        </td>
        <td class="0b">
            <xsl:apply-templates select="." mode="plat"/>
        </td>
        <!--  
        <td class="note">
            <xsl:apply-templates select="tei:note"/>
        </td>
        -->
        <td class="10">
            <xsl:apply-templates select="tei:idno[@type='zotero-uri']"/>
        </td>
    </xsl:template>
    
    <xsl:template name="table-td-ensemble">
        <td class="0a">
            <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
        </td>
        <td class="0b">            
            <xsl:apply-templates select="tei:monogr[2]"/>            
        </td>
        <!--  
        <td class="note">
            <xsl:apply-templates select="tei:note"/>
        </td>
        -->
        <td class="10">
            <xsl:apply-templates select="tei:idno[@type='zotero-uri']"/>
        </td>
    </xsl:template>


    <xsl:template match="tei:idno[@type='zotero-uri']">
        <xsl:variable name="uri" select="."/>
        <a href="{$uri}" target="_blank">vers Zot.</a>
    </xsl:template>

    <xsl:template match="tei:note">
        <xsl:choose>
            <xsl:when test="text()">
                <span class="note">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>NA</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:biblStruct" mode="plat">
        <!-- affiche la référence longue sans survol -->
        <xsl:apply-templates select="tei:monogr[1]" mode="plat"/>
        <xsl:if test="series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
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
