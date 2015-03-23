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
                <!-- for modal window from  http://dynamic-tools.net/toolbox/popUp/-->
                <script type="text/javascript">
                    window.onload = function() {
                    var div = document.createElement('div');
                    div.innerHTML = 'Hello World';
                    document.body.appendChild(div.firstChild);
                    
                    function createPopUp(popUpCode)
                    {
                    var div = document.createElement('div');
                    div.innerHTML = popUpCode;
                    document.body.appendChild(div.firstChild);
                    }
                    
                    
                    };
                </script>
                <style type="text/css"> 
                    <xsl:comment>
                    <![CDATA[ 
                    body{
                        font-family:Verdana, Arial, Helvetica, sans-serif;
                        font-size:11px;
                    }
                    body > h2 {margin-top:3em}
                    table{
                        border-collapse:collapse;
                        border-spacing:2px;
                        border-color:gray;
                        width:95%;
                    }
                   
                    h2
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
                        padding:1.5em 1em;
                    }
                    td{
                        height:50px;
                        vertical-align:bottom;
                    }
                    td.note{
                        word-wrap:break-word;
                        overflow:hidden;                       
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
                    span.title, span.italics{
                        font-style:italic;
                    }                                      
                     span.s, span.a {
                        font-style:normal;
                    }                    
                    span.title > span.title{
                        font-style:normal;
                    }
                     span.s > span.title{
                        font-style:italics;
                    }
                     span.ensemble, span.balise, span.alerte {
                        color:Tomato;
                    }
                    .modal {
                        display: block;
                        padding: 0 1em;
                        text-align: center;
                        width: 50%;
                      }
                      @media (min-width: 43.75em) {
                      
                      .modal {
                        xpadding: 1em 2em;
                        text-align: right;
                      }
                      }
                      
                      .modal > label {
                        background: SlateGray;
                        border-radius: .2em;
                        color: #FFDE16;
                        cursor: pointer;
                        display: inline-block;
                        font-weight: bold;
                        margin: 0.5em 1em;
                        padding: 0.75em 1.5em;
                        -webkit-transition: all 0.55s;
                        transition: all 0.55s;
                      }
                      
                      .modal > label:hover {
                        -webkit-transform: scale(0.97);
                        -ms-transform: scale(0.97);
                        transform: scale(0.97);
                      }
                      
                      .modal input {
                        position: absolute;
                        right: 100px;
                        top: 30px;
                        z-index: -10;
                      }
                      
                      .modal__overlay {
                        background: WhiteSmoke;
                        bottom: 0;
                        left: 0;
                        position: fixed;
                        right: 0;
                        text-align: center;
                        top: 0;
                        z-index: -800;
                      }
                      
                      .modal__box {
                        padding: 1em .75em;
                        position: relative;
                        margin: 1em auto;
                        max-width: 500px;
                        width: 90%;
                      }
                      @media (min-height: 37.5em) {
                      
                      .modal__box {
                        left: 50%;
                        position: absolute;
                        top: 50%;
                        -webkit-transform: translate(-50%, -80%);
                        -ms-transform: translate(-50%, -80%);
                        transform: translate(-50%, -80%);
                      }
                      }
                      @media (min-width: 50em) {
                      
                      .modal__box { 
                        padding: 1.75em; 
                         text-align:left;
                        color:black;
                      }
                      }
                      
                      .modal__box label {
                        background: #FFDE16;
                        border-radius: 50%;
                        color: black;
                        cursor: pointer;
                        display: inline-block;
                        height: 1.5em;
                        line-height: 1.5em;
                        position: absolute;
                        right: .5em;
                        top: .5em;
                        width: 1.5em;                       
                      }
                      
                      .modal__box h2 {
                        color: #FFDE16;
                        margin-bottom: 1em;
                        text-transform: uppercase;
                      }
                      
                      .modal__box p {
                        color: #FFDE16;
                        text-align: left;
                      }
                      
                      .modal__overlay {
                        opacity: 0;
                        overflow: hidden;
                        -webkit-transform: scale(0.5);
                        -ms-transform: scale(0.5);
                        transform: scale(0.5);
                        -webkit-transition: all 0.75s cubic-bezier(0.19, 1, 0.22, 1);
                        transition: all 0.75s cubic-bezier(0.19, 1, 0.22, 1);
                      }
                      
                      input:checked ~ .modal__overlay {
                        opacity: 1;
                        -webkit-transform: scale(1);
                        -ms-transform: scale(1);
                        transform: scale(1);
                        -webkit-transition: all 0.75s cubic-bezier(0.19, 1, 0.22, 1);
                        transition: all 0.75s cubic-bezier(0.19, 1, 0.22, 1);
                        z-index: 800;
                      }
                      
                      input:focus + label {
                        -webkit-transform: scale(0.97);
                        -ms-transform: scale(0.97);
                        transform: scale(0.97);
                      }
                      .popUp
                            {
                            	position: absolute;
                            	top: 1000px;
                            	left: 200px;
                            	text-align: center;
                            	padding: 5px;
                            	border: 1px solid black;
                            	background: white;
                            }

                    ]]>
                    </xsl:comment>
                        
                    
                </style>
            </head>
            <body>
                <h1>IGLouvre - Biblio - Contrôle</h1>
                <p>Date : <xsl:value-of select="current-dateTime()"/></p>
                <p>Tri : <xsl:value-of select="$tri"/></p>
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
                <button onclick='createPopUp(document.getElementById("popUpCode").value)'>Create PopUp</button>
                <br/>
                <!-- fenêtre popup "modal" css 3 from : http://www.cssscript.com/accessible-fullscreen-modal-popup-with-pure-css-css3/ -->
                <div class="modal">
                    <input id="modal" type="checkbox" name="modal" tabindex="1"/>
                    <label for="modal">TEI</label>
                    <div class="modal__overlay">
                        <div class="modal__box">
                            <label for="modal">&#10006;</label>
                            <h2>Code TEI</h2>
                            <xsl:apply-templates select="." mode="codeXML"/>
                            <xsl:value-of select="."></xsl:value-of>
                        </div>
                    </div>
                </div>
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
    <xsl:template match="tei:biblStruct">
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
                            <xsl:when test="position() = last()-1">
                                <xsl:text> et </xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>, </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:for-each>
            <!-- 's.v.' si @type='dictionaryEntry' -->
            <xsl:if test="@type='dictionaryEntry'">
                <span class="italics">
                    <xsl:text>s.&#8239;v.&#160;</xsl:text>
                </span>
            </xsl:if>
            <!-- titre de l'article -->
            <xsl:text> &#171;&#8239;</xsl:text>
            <xsl:apply-templates select="tei:analytic/tei:title[@level='a'][not(@type='short')]"/>
            <xsl:text>&#8239;&#187;</xsl:text>
            <!-- separateur -->
            <xsl:text>, </xsl:text>
            <!-- in -->
            <xsl:if test="@type='bookSection' or @type='conferencePaper'">
                <xsl:value-of select="$in"/>
            </xsl:if>
        </xsl:if>
        <!-- createurs -->
        <!-- on traite d'abord les auteurs / editeurs  -->
        <xsl:if test="(tei:monogr[1]/tei:author or tei:monogr[1]/tei:editor or tei:monogr[1]/tei:respStmt) and not(@type='dictionaryEntry')">
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
                        <xsl:text>trad.&#160;</xsl:text>
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
        <!-- titre du volume ou du périodique-->
        <xsl:choose>
            <xsl:when test="@type='dictionaryEntry'">
                <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:when test="@type='journalArticle' or @type='conferencePaper'">
                <xsl:choose>
                    <xsl:when test="tei:monogr[1]/tei:title[@type='short']">
                        <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="tei:monogr[1]/tei:title[@level='m']">
                    <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
                    <!-- separateur -->
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <!-- meeting -->
        <xsl:if test="@type='conferencePaper' and tei:monogr[1]/tei:meeting">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:meeting"/>
        </xsl:if>
        <!-- collection -->
        <xsl:if test="tei:series">
            <xsl:apply-templates select="tei:series"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- numéro de volume -->
        <xsl:if test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection' and tei:monogr/tei:biblScope[@unit='volume']">
            <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='volume']"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- date de publication -->
        <xsl:apply-templates select="tei:monogr[1]/tei:imprint/tei:date"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
        <!-- pas compris ? extent ? -->
        <!-- pagination -->
        <xsl:if test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection'">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='pp']"/>
        </xsl:if>
        <!-- point final -->
        <xsl:text>.</xsl:text>
    </xsl:template>
    <!--  -->
    <!--  -->
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
        <xsl:value-of select="concat(upper-case(substring(.,1,1)),'.&#160;')"/>
    </xsl:template>
</xsl:stylesheet>
