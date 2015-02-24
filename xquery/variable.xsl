<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl tei html">
    <xsl:output method='xml'/>
    <xsl:template match="/">
        <html>
            <body>
                <div>
                    <xsl:for-each select='//titleStmt/title'>
                       <b><xsl:apply-templates select='.'/></b>: <br/>
                    </xsl:for-each>
                    <ul>
                    <xsl:for-each select="//biblStruct[@type='book']">
                        <li>
                            <xsl:text> </xsl:text>            
                            <xsl:apply-templates select="monogr/imprint/date/@when"/>
                        </li>
                    </xsl:for-each>
                    </ul>
                </div>
            </body>
        </html>
    </xsl:template>
          
</xsl:stylesheet>


