<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:vcard="http://nwalsh.com/rdf/vCard#" 
    xmlns:foaf="http://xmlns.com/foaf/0.1/" 
    xmlns:z="http://www.zotero.org/namespaces/export#"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:bib="http://purl.org/net/biblio#" 
    xmlns:link="http://purl.org/rss/1.0/modules/link/"
    xmlns:prism="http://prismstandard.org/namespaces/1.2/basic/" 
    exclude-result-prefixes="xs rdf tei  dc vcard foaf z dcterms bib link prism"
    >
    <!-- Projet Iglouvre - Emmanuelle Morlock - transformations xslt pour la bibliographie -->
    
    <!-- 
    [Créateur], [Titre. Sous-titre], [édition], [Titre de la collection]* [numéro dans la collection]**, [date de publication], [nombre de volumes].
    
    É. Samama, Les médecins dans le monde grec. Sources épigraphiques sur la naissance d’un corps médical, Hautes études du monde romain 31, 2003.
    -->
    <xsl:output 
        method='xml'
        omit-xml-declaration='no'
        indent='yes'
        doctype-public='-//W3C//DTD XHTML 1.0 Transitional//EN' 
        doctype-system='http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd' />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>fichier de test</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            </head>
            <body>
            
            <h1>
                bibliographie transfos              
            </h1>
            
                <xsl:apply-templates select="listBibl"/>
                <xsl:apply-templates/>
            
        </body>
        </html>
       
    </xsl:template>
    
    
    
    
    
    <xsl:template match="listBibl">
        <xsl:text>toto</xsl:text>
        <div class="bibl">
            <ul>
                <xsl:apply-templates select="biblStruct[@type='book']"/>
            </ul>
       
        </div>
    </xsl:template>
    
    <xsl:template match="biblStruct">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="author|editor">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="forename">
        <xsl:value-of select="substring(.,1,1)"></xsl:value-of></xsl:template>
        
    <xsl:template match="surname"><xsl:apply-templates/></xsl:template>
 
    
</xsl:stylesheet>