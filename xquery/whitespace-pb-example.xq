
(: Outputs the result as html. :)
declare option output:method 'html';

(: Turn whitespace chopping off. :)
declare option db:chop 'no';
 
let $in :=
  db:open('my_biblio')//TEI
  
let $style :=
  <xsl:stylesheet version='2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml">
  <xsl:output method='xml' omit-xml-declaration = "yes"/>
  
  <xsl:param name="charSpace" xml:space="preserve"> 
         <xsl:text>&#32;</xsl:text>
  </xsl:param>
  
    <xsl:template match="/">   
     <html>
            <body>
                <div>
                <ul>
                    <xsl:for-each select="//biblStruct[@type='book']">
                        <li><xsl:apply-templates select="."/></li>
                    </xsl:for-each>
                    </ul>
                </div>
            </body>
        </html>       
    </xsl:template>
    
   <xsl:template match="biblStruct">
        <xsl:if test="monogr/title[not(@type='short')]">
            <xsl:call-template name="title"/>
            <xsl:text>,</xsl:text>
        </xsl:if>        
        <xsl:call-template name="publicationDate"/>       
    </xsl:template>


    <xsl:template name="publicationDate">    
         <xsl:value-of select="$charSpace"/>
       
        <xsl:apply-templates select="monogr/imprint/date/@when"/>
    </xsl:template>


    <xsl:template name="title">
        <span class="title">
            <xsl:choose>
                <xsl:when test="monogr[1]/title[not(@type='short')]/text()">                    
                    <xsl:for-each select="monogr[1]/title[not(@type='short')]">
                        <xsl:apply-templates select="."/>                       
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>pas de titre </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>


  </xsl:stylesheet>
 
return xslt:transform($in, $style)
