<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl tei html">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> March 23, 2015</xd:p>
            <xd:p><xd:b>Author:</xd:b> Emmanuelle Morlock</xd:p>
            <xd:p>IGLouvre project's stylesheet: Transformation of bibliographic data for quality control.</xd:p>
        </xd:desc>
    </xd:doc>
    <!-- todo : nombre de volumes -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!-- +++++++++++++++++++++ éléments non affichés -->
    <xsl:template match="idno"/>
    <xsl:template match="//tei:respStmt/tei:resp"/>
    <!-- +++++++++++++++++++++ Templates nommés -->
    <!-- +++++++++++++++++++++ ================ -->
    <xsl:template match="tei:idno[@type='zotero-uri']">
        <xsl:variable name="uri" select="."/>
        <a href="{$uri}" target="_blank">Zot.</a>
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
    <xsl:template name="makeCreator">
        <xsl:param name="creator"/>
        <xsl:param name="separator"/>
        <xsl:choose>
            <xsl:when test="local-name()='author'">
                <xsl:apply-templates/>
                <xsl:value-of select="$separator"/>
            </xsl:when>
            <xsl:when test="local-name()='editor' and @role='scientificEditor'">
                <xsl:apply-templates/>
                <xsl:text>&#160;(éd.)</xsl:text>
                <xsl:value-of select="$separator"/>
            </xsl:when>
            <xsl:when test="local-name()='editor' and @role='seriesEditor'">
                <xsl:apply-templates/>
                <xsl:text>&#160;(dir.)</xsl:text>
                <xsl:value-of select="$separator"/>
            </xsl:when>
        </xsl:choose>
        <!-- 'and' or 'comma' separator -->
    </xsl:template>
    <!--  template match -->
    <xsl:template match="tei:biblScope">
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="tei:biblScope[@unit='volume']">
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="tei:biblScope[@unit='pp']">
        <xsl:text>&#160;</xsl:text>
        <xsl:text>p.&#160;</xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="date">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:imprint/tei:date">
        <xsl:value-of select="@when"/>
    </xsl:template>
    <xsl:template match="tei:forename">
        <!-- pour tester 
        <xsl:value-of select="concat('|',.,'|')"></xsl:value-of>
        <xsl:text> </xsl:text>
        si le prénom commence par une voyelle -->
        <xsl:analyze-string select="." regex="(^[aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])(.[^\-]*)(\-?)(.*)">
            <xsl:matching-substring>
                <!-- <xsl:text>voyelle</xsl:text> -->
                <tei:forename>
                    <xsl:value-of select="concat(upper-case(regex-group(1)),'.')"/>
                    <xsl:choose>
                        <xsl:when test="not(regex-group(3) = '')">
                            <xsl:value-of select="regex-group(3)"/>
                            <xsl:value-of select="concat(upper-case(substring(regex-group(4),1,1)),'. ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </tei:forename>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <!-- si digramme + r ou l  -->
                <xsl:analyze-string select="." regex="(^[^aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])([hrl])([rl])(.[^\-]*)(\-?)(.*)">
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
                                    <xsl:value-of select="concat(upper-case(substring(regex-group(6),1,1)),'. ')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> </xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tei:forename>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <!-- si digramme   -->
                        <xsl:analyze-string select="." regex="(^[^aeoiuyéèàùâêîôûäëïöüAEIOUYÉÈÀÙÂÊÎÔÛÄËÏÖÜ])([hrl])(.[^\-]*)(\-?)(.*)">
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
                                            <xsl:value-of select="concat(upper-case(substring(regex-group(5),1,1)),'. ')"/>
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
                                                <xsl:value-of select="upper-case(substring(regex-group(1),1,1))"/>
                                                <xsl:if test="not(starts-with(regex-group(1),' '))">
                                                    <!-- bizarre mais seule manière trouvée de ne pas avoir un point isolé -->
                                                    <xsl:text>.</xsl:text>
                                                </xsl:if>
                                                <xsl:choose>
                                                    <xsl:when test="not(regex-group(2)='')">
                                                        <xsl:value-of select="regex-group(2)"/>
                                                        <xsl:value-of select="concat(upper-case(substring(regex-group(3),1,1)),'. ')"/>
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
    <!-- ++++++++++++++++++++++  template match -->
    <!-- +++++++++++++++++++++ ================ -->
    <!--  
   
    -->
    <!-- traitement des <i> et </i> dans les champs zotero pour gérer les italiques -->
    <xsl:template match="*" mode="zoteroItalics">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="zoteroItalics"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="text()" mode="zoteroItalics">
        <xsl:analyze-string select="." regex="(&lt;i&gt;)(.*)(&lt;/i&gt;)">
            <xsl:matching-substring>
                <span class="title">
                    <xsl:value-of select="regex-group(2)"/>
                </span>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    <xsl:template match="*" mode="codeXML">
        <span class="balise">
            <br/>
            <xsl:text>&lt;</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:apply-templates select="@*" mode="codeXML"/>
            <xsl:text>&gt;</xsl:text>
        </span>
        <xsl:apply-templates mode="codeXML"/>
    </xsl:template>
    <xsl:template match="@*" mode="codeXML">
        <xsl:value-of select="concat(' ',local-name(), '=', '&quot;',.,'&quot;')"/>
    </xsl:template>
    <xsl:template match="text()" mode="codeXML">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="tei:title">
        <xsl:variable name="atts" select="concat('title',' ', @level)"/>
        <span class="{$atts}">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    <!-- titre d'ensemble -->
    <xsl:template match="tei:monogr[2]/tei:title">
        <xsl:variable name="atts" select="concat('title ensemble',' ', @level)"/>
        <span class="{$atts}">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    <xsl:template match="tei:meeting">
        <span class="meeting">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
</xsl:stylesheet>
