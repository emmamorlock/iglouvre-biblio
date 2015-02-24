<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">
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


    <!-- +++++++++++++++++++++ éléments non affichés -->
    <xsl:template match="idno"/>
    <xsl:template match="tei:respStmt/tei:resp"/>

    <!-- +++++++++++++++++++++ Templates nommés -->

    <xsl:template name="creators">
        <xsl:param name="context"/>        
        <xsl:for-each select="$context/tei:author|$context/tei:editor|$context/tei:respStmt">
            <xsl:variable name="string">
                <xsl:apply-templates/>
            </xsl:variable>
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
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:variable>
            <!-- 1/ Name and role -->
            <xsl:choose>
                <!-- contributor role in resp-->
                <xsl:when test="@type= 'contributor'">
                    <xsl:text> (avec </xsl:text>
                    <xsl:value-of select="normalize-space($string)"/>
                    <!-- todo : ajouter récursion si on a plusieurs collaborateurs -->
                    <xsl:text>)</xsl:text>
                </xsl:when>
                <!-- general case -->
                <xsl:otherwise>
                    <!-- <xsl:value-of select="normalize-space(concat($string, ' ', $role))"/> -->
                    <xsl:variable name="result" select="$string"/>
                    <xsl:value-of
                        select="normalize-space(concat(normalize-space($result),' ',$role))"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- 2/ separator -->
            <!-- 'and' or 'comma' separator -->
            <xsl:choose>
                <xsl:when
                    test="count(following-sibling::tei:*[local-name()='author' or local-name()='editor' or local-name()='respStmt']) = 1">
                    <xsl:text> et </xsl:text>
                </xsl:when>
                <xsl:when
                    test="count(following-sibling::tei:*[local-name()='author' or local-name()='editor' or local-name()='respStmt']) != 0">
                    <xsl:text>, </xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="publicationDate">
        <!-- virgule avant s'affiche aussi après ???
        <xsl:text>, </xsl:text>
        -->
        <xsl:param name="context"/>
       <xsl:value-of select="name($context)"/>
          
      
        
    </xsl:template>


    <xsl:template name="series">
        <!-- virgule avant -->
        <xsl:text>, </xsl:text>
        <span class="title">
            <xsl:value-of select="../tei:series/tei:title"/>
        </span>
        <xsl:text> </xsl:text>
        <xsl:if test="../tei:series/tei:biblScope">
            <xsl:value-of select="../tei:series/tei:biblScope"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="title">
        <!-- virgule avant -->
        <span class="title">
            <xsl:choose>
                <xsl:when test="tei:title[not(@type='short')]">
                    <xsl:for-each select="tei:title[not(@type='short')]">
                        <xsl:if
                            test="parent::tei:monogr/tei:author or parent::tei:monogr/tei:editor or parent::tei:monogr/tei:respStmt">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>pas de titre </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>


    <!--  template match -->


    <xsl:template match="tei:series/tei:biblScope">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="tei:biblScope">
        <xsl:if test="@unit">
            <xsl:value-of select="concat(@unit,'.')"/>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="tei:monogr/tei:biblScope[@unit='vol']">
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
        <!-- pour tester 
        <xsl:value-of select="concat('|',.,'|')"></xsl:value-of>
        <xsl:text> </xsl:text>
        si le prénom commence par une voyelle -->
        <xsl:analyze-string select="."
            regex="(^[aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])(.[^\-]*)(\-?)(.*)">

            <xsl:matching-substring>
                <!-- <xsl:text>voyelle</xsl:text> -->
                <tei:forename>
                    <xsl:value-of select="concat(upper-case(regex-group(1)),'.')"/>
                    <xsl:choose>
                        <xsl:when test="not(regex-group(3) = '')">
                            <xsl:value-of select="regex-group(3)"/>
                            <xsl:value-of
                                select="concat(upper-case(substring(regex-group(4),1,1)),'. ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </tei:forename>
            </xsl:matching-substring>

            <xsl:non-matching-substring>
                <!-- si digramme + r ou l  -->
                <xsl:analyze-string select="."
                    regex="(^[^aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])([hrl])([rl])(.[^\-]*)(\-?)(.*)">
                    <xsl:matching-substring>
                        <!-- <xsl:text>consonne trigr</xsl:text> -->

                        <tei:forename>
                            <!-- <xsl:text>1</xsl:text> -->
                            <xsl:value-of select="upper-case(regex-group(1))"/>
                            <xsl:value-of select="regex-group(2)"/>
                            <xsl:value-of select="regex-group(3)"/>
                            <xsl:text>.</xsl:text>
                            <xsl:choose>
                                <xsl:when test="not(regex-group(5)='')">
                                    <xsl:value-of select="regex-group(3)"/>
                                    <xsl:value-of
                                        select="concat(upper-case(substring(regex-group(6),1,1)),'. ')"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tei:forename>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>

                        <!-- si digramme   -->
                        <xsl:analyze-string select="."
                            regex="(^[^aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])([hrl])(.[^\-]*)(\-?)(.*)">
                            <xsl:matching-substring>
                                <!-- <xsl:text>consonne digr</xsl:text> -->

                                <tei:forename>
                                    <!-- <xsl:text>2</xsl:text> -->
                                    <xsl:value-of select="upper-case(regex-group(1))"/>
                                    <xsl:value-of select="regex-group(2)"/>
                                    <xsl:text>.</xsl:text>
                                    <xsl:choose>
                                        <xsl:when test="not(regex-group(4)='')">
                                            <xsl:value-of select="regex-group(4)"/>
                                            <xsl:value-of
                                                select="concat(upper-case(substring(regex-group(5),1,1)),'. ')"
                                            />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text> </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </tei:forename>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <tei:forename>
                                    <!-- 
                                    <xsl:value-of select="concat('|',.,'|')"></xsl:value-of>
                                    <xsl:value-of select="concat(upper-case(substring(.,1,1)),'. ')"/>  
                                     -->

                                    <xsl:analyze-string select="." regex="(.[^\-]*)(\-?)(.*)">
                                        <xsl:matching-substring>
                                            <tei:forename>

                                                <!-- <xsl:text>3</xsl:text> -->
                                                <!--  <xsl:value-of select="concat('|1',regex-group(1),'|2',regex-group(2),'|3',regex-group(3),'|4',regex-group(4),'|')"></xsl:value-of>-->
                                                <xsl:value-of
                                                  select="upper-case(substring(regex-group(1),1,1))"/>
                                                <xsl:if test="not(starts-with(regex-group(1),' '))">
                                                  <!-- bizarre mais seule manière trouvée de ne pas avoir un point isolé -->
                                                  <xsl:text>.</xsl:text>
                                                </xsl:if>
                                                <xsl:choose>
                                                  <xsl:when test="not(regex-group(2)='')">
                                                  <xsl:value-of select="regex-group(2)"/>
                                                  <xsl:value-of
                                                  select="concat(upper-case(substring(regex-group(3),1,1)),'. ')"
                                                  />
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:text> </xsl:text>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </tei:forename>
                                        </xsl:matching-substring>
                                        <xsl:non-matching-substring>
                                            <!--  <xsl:text>4</xsl:text>-->
                                            <!--  
                                            <xsl:value-of select="concat('|',.,'|')"></xsl:value-of>-->
                                            <!-- <xsl:value-of select="upper-case(substring(.,1,1))"/>  -->
                                        </xsl:non-matching-substring>
                                    </xsl:analyze-string>
                                </tei:forename>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>

        </xsl:analyze-string>

    </xsl:template>

<!-- +++++++++++++++++++++++++++++++++ monographies -->

    <xsl:template match="tei:monogr[1]">
        <xsl:if test="tei:author or tei:editor or tei:respStmt">
            <xsl:call-template name="creators"/>
        </xsl:if>
        <xsl:call-template name="title"/>
        <xsl:if test="../tei:series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->
    </xsl:template>

    <xsl:template match="tei:monogr[1]" mode="longRef">
        <xsl:if test="tei:author or tei:editor or tei:respStmt">
            <xsl:call-template name="creators"/>
        </xsl:if>
        <xsl:variable name="shortRef" select="tei:title[@type='short']"/>
        <a href="#" title="{$shortRef}">
            <xsl:call-template name="title"/>
        </a>
        <xsl:if test="../tei:series">
            <xsl:call-template name="series"/>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->

    </xsl:template>

    <xsl:template match="tei:monogr[1]" mode="plat">
        <!-- sans lien -->
        <xsl:if test="tei:author or tei:editor or tei:respStmt">
            <xsl:call-template name="creators">
                <xsl:with-param name="context" select="."/>
            </xsl:call-template>
            <xsl:text>calling </xsl:text>
        </xsl:if>
        <xsl:call-template name="title"/>
        <xsl:if test="../tei:series">
            <xsl:call-template name="series"/>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->
    </xsl:template>

    <xsl:template match="tei:monogr[2]">
        <xsl:variable name="context" select="preceding-sibling::tei:monogr[1]"/>     
            <xsl:if test="../tei:monogr[1]/tei:author or ../tei:monogr[1]/tei:editor or ../tei:monogr[1]/tei:respStmt">
            <xsl:call-template name="creators">
                <xsl:with-param name="context" select="$context"/>                   
            </xsl:call-template>
        </xsl:if>                               
        <xsl:apply-templates select="tei:monogr[2]"/>
        <xsl:text>. </xsl:text>
        <xsl:apply-templates select="tei:monogr/tei:biblScope[@unit='vol']"/>
        <xsl:call-template name="title"/>
        <xsl:if test="../tei:series">
            <xsl:call-template name="series"/>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:call-template name="publicationDate">
            <xsl:with-param name="context" select="$context"/>   
        </xsl:call-template>            
    </xsl:template>


   


    <xsl:template match="tei:surname">
        <xsl:value-of select="concat(upper-case(substring(.,1,1)),substring(., 2))"/>
    </xsl:template>

</xsl:stylesheet>
