<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version='2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
    <xsl:output method='xml'/>
    <xsl:template match="/">
        <html>
            <body>
                <div>
                    <xsl:for-each select='//titleStmt/title'>
                        • <b><xsl:apply-templates select='.'/></b>: <br/>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>


