<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">
   
 <!-- 
    MONOGAPHIES
    [Créateur], [Titre. Sous-titre], [Titre de la collection]* [numéro dans la collection]**, [date de publication], [nombre de volumes].
    É. Samama, Les médecins dans le monde grec. Sources épigraphiques sur la naissance d’un corps médical, Hautes études du monde romain 31, 2003.
    
    CONTRIBUTIONS A DES OUVRAGES
    [Auteur], « [Titre de l’article] », in [Créateur], [Titre de l’ouvrage. Sous-titre de l’ouvrage], [édition], [Titre de la collection] * [numéro dans la collection] **, [date de publication], [localisation].
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

 -->    
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- +++++++++++++++++++++ éléments non affichés -->
    <xsl:template match="idno"/>
    <!-- ++++++++++++++++++++ -->

    <xsl:template match="tei:TEI">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
                <link rel="stylesheet" type="text/css" media="screen, projection" href="theores.css"
                />
            </head>
            <xsl:apply-templates select="//tei:listBibl/tei:biblStruct[@xml:id='testEM1']"/>
        </html>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <body>           
            <div class="bibl">
                <ul>
                    <xsl:apply-templates select="tei:biblStruct"/>
                </ul>
            </div>
        </body>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct">
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:call-template name="doCreator">                        
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </li>
    </xsl:template>   
   
    
    <xsl:template name="Creators">
      <xsl:for-each select="tei:author|tei:editor">
          <xsl:call-template name="doCreator"/>
          <xsl:if test="not(position()=last())">
              <xsl:text>, </xsl:text>
          </xsl:if>   
      </xsl:for-each>       
    </xsl:template>  
  
  <xsl:template name="doCreator">
      <span class="creator">
        <xsl:apply-templates />
      </span>
  </xsl:template>
    
    
    <!-- 
    
    <xsl:template match="t:author[count(../t:author)=1]">
        <xsl:call-template name="emitcontributorref"/>
    </xsl:template>
    
    -->
    
  <xsl:template match="tei:author">
      <xsl:apply-templates select="."/>
  </xsl:template>
    
    <xsl:template match="tei:editor">
        <xsl:apply-templates select="."/>
        <xsl:text> (ed.)</xsl:text>
  </xsl:template>
    
    
    <!-- 
    <xsl:template match="tei:respStmt">
        <xsl:apply-templates select='tei:persName'/>
        <xsl:text> (</xsl:text>
      
        <xsl:choose>
            <xsl:when test="contains(tei:resp,'contributor')">
                <xsl:text>avec</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>perdu !</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:text>) </xsl:text>
        

    </xsl:template>
         -->
    
    
    <xsl:template match="tei:forename">
        <xsl:value-of select="concat(substring(.,1,1),'. ')"/></xsl:template>
    
    <xsl:template match="tei:surname"><xsl:apply-templates/></xsl:template>

</xsl:stylesheet>
