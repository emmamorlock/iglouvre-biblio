
(: Outputs the result as html. :)
declare option output:method 'html';

(: Turn whitespace chopping off. :)
declare option db:chop 'no';
 
let $in :=
  db:open('igl_bibliography')//TEI
  
let $style :=
  <xsl:stylesheet version='2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml">
  <xsl:output method='xml' omit-xml-declaration = "yes"/>
    <xsl:template match="/">
    
     <html>
            <body>
                <div>
                <ul>
                    <xsl:for-each select="//biblStruct[@type='book']">
                        <li><xsl:apply-templates select="." mode="longRef"/></li>
                    </xsl:for-each>
                    </ul>
                </div>
            </body>
        </html>
    
        
    </xsl:template>
    
 <xsl:template match="biblStruct" mode="longRef">
        <!-- affiche la référence longue avec la référence abrégée au survol -->
        <xsl:apply-templates select="monogr[1]" mode="longRef"/>
        <xsl:if test="series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
    </xsl:template>

    <xsl:template match="biblStruct" mode="shortRef">
        <!-- affiche la référence abrégée avec la référence longue au survol -->
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:variable name="id" select="@xml:id"/>
                    <xsl:variable name="linkUri" select="idno[@type='zotero-uri']"/>
                    <xsl:variable name="longRef">
                        <xsl:apply-templates select="monogr[1]"/>
                        <xsl:if test="series">
                            <xsl:call-template name="series"/>
                            <xsl:text>,</xsl:text>
                        </xsl:if>
                        <xsl:call-template name="publicationDate"/>
                    </xsl:variable>
                    <!--  <xsl:variable name="test" select="translate(normalize-unicode($longRef),'áàâäéèêëíìîïóòôöúùûü','aaaaeeeeiiiioooouuuu')"/>-->
                    <span class="shortRef">
                        <xsl:element name="a>">
                          <xsl:attribute name="href">
                            <xsl:value-of select="$linkUri"/>
                          </xsl:attribute>
                          <xsl:attribute name="title">
                           <xsl:value-of select="$longRef"/>
                          </xsl:attribute>
                          <xsl:value-of select="monogr/title[@type='short']"/>
                        </xsl:element>
                    </span>
                </xsl:when>
            </xsl:choose>
        </li>
    </xsl:template>
   

    <xsl:template match="biblStruct" mode="longRef">
        <!-- affiche la référence longue avec la référence abrégée au survol -->
        <xsl:apply-templates select="monogr[1]" mode="longRef"/>
        <xsl:if test="series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO : nombre de volumes : ajouter le champ en TEI via le translator zotero -->
    </xsl:template>

    <xsl:template match="biblStruct" mode="shortRef">
        <!-- affiche la référence abrégée avec la référence longue au survol -->
        <li>
            <xsl:choose>
                <xsl:when test="@type='book'">
                    <xsl:variable name="id" select="@xml:id"/>
                    <xsl:variable name="linkUri" select="idno[@type='zotero-uri']"/>
                    <xsl:variable name="longRef">
                        <xsl:apply-templates select="monogr[1]"/>
                        <xsl:if test="series">
                            <xsl:call-template name="series"/>
                            <xsl:text>,</xsl:text>
                        </xsl:if>
                        <xsl:call-template name="publicationDate"/>
                    </xsl:variable>
                    <!--  <xsl:variable name="test" select="translate(normalize-unicode($longRef),'áàâäéèêëíìîïóòôöúùûü','aaaaeeeeiiiioooouuuu')"/>-->
                    <span class="shortRef">
                        <xsl:element name="a>">
                          <xsl:attribute name="href">
                            <xsl:value-of select="$linkUri"/>
                          </xsl:attribute>
                          <xsl:attribute name="title">
                            <xsl:value-of select="monogr/title[@type='short']"/>
                          </xsl:attribute>
                          <xsl:value-of select="tei:monogr/tei:title[@type='short']"/>
                        </xsl:element>
                    </span>
                </xsl:when>
            </xsl:choose>
        </li>
    </xsl:template>
    
    
    <!-- +++++++++++++++++++++ éléments non affichés -->
    
    <xsl:template match="idno"/>
    <xsl:template match="respStmt/resp"/>
    
    <!-- +++++++++++++++++++++ Templates nommés -->


    <xsl:template name="creators">
        <xsl:for-each select="author|editor|respStmt">
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
                    <xsl:value-of select="normalize-space($result)"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- 2/ separator -->
            <!-- 'and' or 'comma' separator -->
            <xsl:choose>
                <xsl:when
                    test="count(following-sibling::*[local-name()='author' or local-name()='editor' or local-name()='respStmt']) = 1">
                    <xsl:text> et </xsl:text>
                </xsl:when>

                <xsl:when
                    test="count(following-sibling::*[local-name()='author' or local-name()='editor' or local-name()='respStmt']) != 0">
                    <xsl:text>, </xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>


    <xsl:template name="publicationDate">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="imprint/date/@when" mode="longRef"/>
    </xsl:template>


    <xsl:template name="series">
        <span class="title">
            <xsl:value-of select="../series/title"/>
        </span>
        <xsl:text> </xsl:text>
        <xsl:if test="../series/biblScope">
            <xsl:value-of select="../series/biblScope"/>
        </xsl:if>
    </xsl:template>


    <xsl:template name="title">
      
        <span class="title">
            <xsl:choose>
                <xsl:when test="title[not(@type='short')]/text()">
                    
                    <xsl:for-each select=".">
                        <xsl:apply-templates select="title[not(@type='short')]"/>
                       
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>pas de titre </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>


    <!--  template match -->


    <xsl:template match="series/biblScope">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="biblScope">
        <xsl:if test="@unit">
            <xsl:value-of select="concat(@unit,'.')"/>
        </xsl:if>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template name="date">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="editor">
        <span class="editor">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="forename">
     <xsl:value-of select="concat((substring(.,1,1)),'. ')"/>                  
    </xsl:template>


    <xsl:template match="monogr[1]">
        <xsl:call-template name="creators"/>
        <xsl:text> </xsl:text>
        <xsl:call-template name="title"/>
        <xsl:if test="../series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->
    </xsl:template>

    <xsl:template match="monogr[1]" mode="longRef">
        <xsl:call-template name="creators"/>
        <xsl:text> </xsl:text>
        <xsl:variable name="shortRef" select="title[@type='short']"/>
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="$shortRef"/>
          </xsl:attribute>
        </xsl:element>
       
        <xsl:if test="../series">
            <xsl:call-template name="series"/>
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:call-template name="publicationDate"/>
        <!-- #TODO ajouter tpl nombre volumes -->
    </xsl:template>

    <xsl:template match="monogr[2]">
        <!-- titre ensemble -->
        <xsl:if test="monogr[2]">
            <span class="title">
                <xsl:apply-templates select="title"/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="series">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="surname">
        <xsl:value-of select="concat((substring(.,1,1)),substring(., 2))"/>
    </xsl:template>
    
   
  </xsl:stylesheet>
 
return xslt:transform($in, $style)
