<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl tei html">
    <xsl:import href="iglouvre-biblio-commun.xsl"/>
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> March 23, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> Emmanuelle Morlock</xd:p>
            <xd:p>IGLouvre project's stylesheet: Transformation of bibliographic data for quality control.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
    <!-- todo : nombre de volumes -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!-- +++++++++++++++++++++ paramètres -->
    <xsl:param name="in">
        <xsl:text>in </xsl:text>
    </xsl:param>
    <!-- +++++++++++++++++++++ Structure de la page -->
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>IGLouvre - biblio - contrôle qualité</title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
                <!-- google fonts -->
                <link href="http://fonts.googleapis.com/css?family=Droid+Sans+Pro|Lora|Cantarell|Droid+Serif|Inconsolata|Yanone+Kaffeesatz" rel="stylesheet" type="text/css"/>
                <!--  -->
                <style type="text/css"> 
                    <xsl:comment>
                    <![CDATA[ 
                    body{
                        font-family:Inconsolata, sans-serif;
                        font-size:12px;
                    }
                    body > h2 {margin:3em 0 1.8em 0}
                    h2 {text-align:center}
                    table{
                        border-collapse:collapse;
                        border-spacing:2px;
                        border-color:gray;
                        width:85%;
                        margin-left:auto;
                        margin-right:auto;
                    }
                    h2, th{
                        font-family:'Yanone Kaffesatz', sans-serif;font-size:2em;
                    }
                    table, th, td{
                        border:1px solid #98bf21;
                        font-family:Inconsolata,sans-serif;
                    }
                    thead {font-weight:bold;color:blueviolet;}
                    td{
                        text-align:left;                        
                        padding:1.5em 1em;
                        font-family:Cantarell,serif;
                    }
                    td{
                        height:50px;
                        vertical-align:top;
                    }
                    td.note{
                        word-wrap:break-word;
                        overflow:hidden;  
                        font-size:.75em;                       
                    } 
                    td.longue {font-family:Cantarell,sans-serif;max-width:30em;}

                    td.allege {font-family:Cantarell,sans-serif;max-width:30em;}
                    
                    td.lemme {font-family:Cantarell,sans-serif;max-width:30em;min-width:15em;}
                    
                    td.liens {max-width:10em;}
                   
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
                    span.title, span.italics, span.allege .meeting{
                        font-style:italic;
                    }                                      
                     span.s, span.a {
                        font-style:normal;
                    }                    
                    span.title > span.title{
                        font-style:normal;
                    }
                     span.s > span.title{
                        font-style:italic;
                    }
                     span.balise, span.alerte {
                        color:Tomato;
                    }
                    sup {font-size:.7em; font-style:italic;margin-left: -.2em;}
                    
                    .allege .meeting{font-style:italic;}
                    
                     
                    /* ************************ */
                    /* à modifier selon confort 
                    / ************************** */
                    
                    .test {color:silver}
                    .normal {color:black;}
                    .s {color:VioletRed}
                    .ensemble {color:Tomato;}
                    .lemme {}
                    .longue .note { color:Fuchsia; }                    
                    .allege .test, .allege .s, .allege .ensemble {color:black;}
                  
                   /* ******************************** */
                   /* stylage du popup                  */
                   /* from  pop up from http://websemantics.co.uk/resources/accessible_css3_modal_pop-ups/#links */
                   /* *********************************** */
                       .pop-up {position:absolute; top:0; left:-500em}
                       .pop-up:target {position:absolute; left:0;}
                       .popBox {
                            background:AliceBlue;
                            font-size:.85em;
                            min-height:50%;
                            height:auto;
                            padding: 1.75em; 
                            text-align:left;
                            text-indent:3em;
                            font-family:Consolas,monospace;
                          
                            /* alternatively fixed width / height and negative margins from 50% */
                            position:absolute; left:30%; top:15%;
                          
                            z-index:1;
                            /* padding:1%; removed 17/07/2012 */
                            border:1px solid #3a3a3a;
                          
                            /* CSS3 rounded corners, drop-shadow and opacity fade in */
                            -moz-border-radius:12px;
                            border-radius:12px;
                            -webkit-box-shadow:2px 2px 4px #3a3a3a;
                            -moz-box-shadow:2px 2px 4px #3a3a3a;
                            box-shadow:2px 2px 4px #3a3a3a;
                            opacity:0;
                            -webkit-transition: opacity 0.5s ease-in-out;
                            -moz-transition: opacity 0.5s ease-in-out;
                            -o-transition: opacity 0.5s ease-in-out;
                            -ms-transition: opacity 0.5s ease-in-out;
                            transition: opacity 0.5s ease-in-out;
                          }
                          :target .popBox {position:fixed; opacity:1;}                         
                          .popBox:hover {box-shadow:3px 3px 6px #5a5a5a;}
                          .popBox a.close{position:absolute;right:2em;bottom:2em;}
                          .popBox h2{text-indent:0;}
  
                    ]]>
                    </xsl:comment>         
                </style>
            </head>
            <body>
                <h1>IGLouvre - Biblio - Contrôle</h1>
                <p>Date : <xsl:value-of select="current-dateTime()"/></p>
                <p>Critères de tri : Titre d'ensemble | Collection | Créateur | Année de publication</p>
                <xsl:for-each-group select="//tei:biblStruct" group-by="./@type">
                    <h2>Type Zotero : <xsl:value-of select="current-grouping-key()"/></h2>
                    <table>
                        <thead>
                            <tr>
                                <td class="longue">Forme longue<br/><i>pour bibliographie générale</i></td>
                                <td class="lemme">Forme courte 1.<br/><i>pour lemme ('shortTitle' ∃)</i></td>
                                <td class="allege">Forme courte 2. <br/><i>pour lemme ('shortTitle' ∄)</i></td>
                                <td class="note">Champ 'note'</td>
                                <td class="liens">Liens</td>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="current-group()">
                                <!-- Critères de tri -->
                                <xsl:sort select="tei:monogr[2]"/>
                                <xsl:sort select="tei:series/tei:title[@level='s'][1][not(@type='short')]"/>
                                <xsl:sort select="tei:analytic/tei:author[1]//tei:surname"/>
                                <xsl:sort select="tei:monogr/tei:author[1]//tei:surname"/>
                                <xsl:sort select="tei:monogr/tei:editor[1]//tei:surname"/>
                                <xsl:sort select="tei:monogr/tei:respStmt[1]//tei:surname"/>
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
            <td class="longue">
                <!-- forme de la référence pour la liste bibliographique générale -->
                <xsl:variable name="maintxt">
                    <xsl:apply-templates select="."/>
                </xsl:variable>
                <xsl:variable name="maintxt2">
                    <xsl:apply-templates select="$maintxt" mode="zoteroItalics"/>
                    <xsl:call-template name="pointFinal">
                        <xsl:with-param name="content" select="$maintxt"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:apply-templates select="$maintxt2" mode="zoteroItalics"/>
            </td>
            <td class="lemme">
                <!-- forme de la référence pour le lemme -->
                <xsl:variable name="maintxt">
                    <xsl:apply-templates select="." mode="lemme"/>
                </xsl:variable>
                <xsl:variable name="maintxt2">
                    <xsl:apply-templates select="$maintxt" mode="zoteroItalics"/>
                </xsl:variable>
                <xsl:apply-templates select="$maintxt2" mode="zoteroItalics"/>
            </td>
            <td class="allege">
                <!-- forme allégée -->
                <xsl:variable name="maintxt">
                    <xsl:apply-templates select="." mode="allege"/>
                </xsl:variable>
                <xsl:variable name="maintxt2">
                    <xsl:apply-templates select="$maintxt" mode="zoteroItalics"/>
                    <xsl:call-template name="pointFinal">
                        <xsl:with-param name="content" select="$maintxt"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:apply-templates select="$maintxt2" mode="zoteroItalics"/>
            </td>
            <td class="note">
                <xsl:apply-templates select="tei:note"/>
            </td>
            <td class="liens">
                <!-- pop up from http://websemantics.co.uk/resources/accessible_css3_modal_pop-ups/#links -->
                <xsl:variable name="id" select="@xml:id"/>
                <a href="#{$id}">TEI</a>
                <div id="{$id}" class="pop-up">
                    <div class="popBox">
                        <div class="popScroll">
                            <h2>Code TEI</h2>
                            <xsl:apply-templates select="." mode="codeXML"/>
                        </div>
                        <a href="" class="close">
                            <span>Fermer</span>
                        </a>
                    </div>
                </div>
                <br/>
                <br/>
                <!-- Lien vers zotero -->
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
            <xsl:if test="(@type='book' or @type='thesis') and tei:monogr/tei:biblScope[@unit='volume'] and tei:monogr[1]/tei:biblScope[@unit='volume']">
                <xsl:apply-templates select="tei:monogr[1]/tei:biblScope[@unit='volume']"/>
                <!-- separateur -->
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <!-- titre du volume ou du périodique-->
        <xsl:choose>
            <xsl:when test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection'">
                <xsl:choose>
                    <xsl:when test="tei:monogr[1]/tei:title[@type='short']">
                        <xsl:apply-templates select="tei:monogr[1]/tei:title[@type='short']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
                    </xsl:otherwise>
                </xsl:choose>
                <!-- separateur -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="tei:monogr[1]/tei:title[@level='m']">
                    <xsl:apply-templates select="tei:monogr[1]/tei:title[not(@type='short')]"/>
                </xsl:if>
                <!-- separateur -->
            </xsl:otherwise>
        </xsl:choose>
        <!-- edition -->
        <xsl:if test="tei:monogr[1]/tei:edition">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:edition"/>
        </xsl:if>
        <!-- meeting -->
        <xsl:if test="@type='conferencePaper' and tei:monogr[1]/tei:meeting">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:meeting"/>
        </xsl:if>
        <!-- collection -->
        <xsl:if test="tei:series">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:series"/>
        </xsl:if>
        <!-- numéro de volume -->
        <xsl:if test="(@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection') and tei:monogr[1]/tei:biblScope[@unit='volume']">
            <xsl:apply-templates select="tei:monogr[1]/tei:biblScope[@unit='volume']"/>
        </xsl:if>
        <!-- année de publication -->
        <xsl:if test="tei:monogr[1]/tei:imprint/tei:date">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:imprint/tei:date"/>
        </xsl:if>
        <!-- nombre de volumes -->
        <xsl:if test="tei:monogr[1]/tei:extent">
            <!-- separateur -->
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:extent"/>
        </xsl:if>
        <!-- pagination -->
        <xsl:if test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection'">
            <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='pp']"/>
        </xsl:if>
        <!-- note -->
        <xsl:if test="descendant::tei:note">
            <xsl:text> </xsl:text>
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="descendant::tei:note"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:biblStruct" mode="allege">
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
        <!-- titre du volume ou du périodique-->
        <xsl:choose>
            <xsl:when test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection'">
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
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <!-- edition -->
        <xsl:if test="tei:monogr[1]/tei:edition/text()">
            <!-- si le premier caractère est un chiffre, on l'affiche en exposant pour indiquer le numéro d'édition -->
            <!-- si c'est autre chose, on affiche un message d'alerte -->
            <!-- à documenter dans le guide de saisie Zotero -->
            <xsl:variable name="num">
                <xsl:value-of select="substring(tei:monogr[1]/tei:edition/text(), 1, 1)"/>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="contains('0123456789',$num)">
                    <sup>
                        <xsl:value-of select="$num"/>
                    </sup>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="tei:monogr[1]/tei:edition"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- meeting -->
        <xsl:if test="@type='conferencePaper' and tei:monogr[1]/tei:meeting">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:meeting"/>
        </xsl:if>
        <!-- collection -->
        <!-- pas de collection -->
        <!-- numéro de volume -->
        <xsl:if test="(@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection') and tei:monogr/tei:biblScope[@unit='volume']">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='volume']"/>
        </xsl:if>
        <!-- année de publication -->
        <xsl:if test="tei:monogr[1]/tei:imprint/tei:date">
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="tei:monogr[1]/tei:imprint/tei:date"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
        <!-- pas de extent (nbr volumes) -->
        <!-- pagination -->
        <xsl:if test="(@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection') and tei:monogr/tei:biblScope[@unit='pp']">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='pp']"/>
        </xsl:if>
        <!-- note -->
        <xsl:if test="descendant::tei:note">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="descendant::tei:note"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="pointFinal">
        <xsl:param name="content"/>
        <xsl:if test="not(ends-with($content,'.'))">
            <!-- point final -->
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <xsl:template match="tei:biblStruct" mode="lemme">
        <!-- s'il y a un titre abrégé, on construit la référence courte, sinon rien -->
        <!-- le titre abrégé -->
        <span class="lemme">
            <xsl:choose>
                <xsl:when test="@type='journalArticle' or @type='dictionaryEntry' or @type='conferencePaper' or @type='bookSection'">
                    <xsl:choose>
                        <xsl:when test="tei:analytic/tei:title[@level='a'][@type='short']">
                            <xsl:apply-templates select="tei:analytic/tei:title[@level='a'][@type='short']"/>
                            <!-- separateur -->
                            <xsl:text>, </xsl:text>
                            <!-- citedRange -->
                            <xsl:text>p.&#8239;ou n°&#8239;000...</xsl:text>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@type='book' or @type='thesis'">
                            <xsl:if test="tei:monogr/tei:title[@level='m'][@type='short']">
                                <xsl:variable name="string">
                                    <xsl:apply-templates select="tei:monogr/tei:title[@level='m'][@type='short']"/>
                                </xsl:variable>
                                <xsl:value-of select="concat($string,', ')"/>
                                <!-- citedRange -->
                                <xsl:text>p.&#8239;ou n°&#8239;000...</xsl:text>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <!-- templates de surcharge de iglouvre-biblio-commun.xsl -->
    <xsl:template match="tei:forename">
        <xsl:value-of select="concat(upper-case(substring(.,1,1)),'.&#160;')"/>
    </xsl:template>
</xsl:stylesheet>
