(: XQuery nested inside HTML :)
(: declare namespace tei="http://www.tei-c.org/ns/1.0"; :)
<html>
<head>
<title>IGLouvre - Biblio - Contrôle qualité</title>
<style type="text/css"> 
<!-- 
  body { font-family: Verdana,Arial,Helvetica,sans-serif; font-size:14px; }
  table { border-collapse:collapse; border-spacing:2px; border-color:gray; width:95%; }
  table { width: 100%; }
  th { height: 50px; }
  table, th, td { border: 1px solid #98bf21; }
  td { text-align:left;font-size:90%; padding:3px 7px 2px 7px; }
  td { height: 50px; vertical-align: bottom; }
  td.note { word-wrap: break-word; overflow:hidden; font-size: .75em;}
  thead { font-weight:bold; }
  tr:nth-child(odd) { background-color:#EAF2D3; }
  tr:nth-child(even) { background-color:white; }
  span.resp:nth-child(odd) { display:block; color:maroon; }
  span.resp:nth-child(even) { display:block; color:green; }
  span.role { font-size:75%; }
  
--> 
</style> 
</head>
<body>
<div class="conteneur">

<h1>IGLouvre - Bibliographie - Contrôle qualité</h1>
<h2>Monographies (type Zotero "book") </h2>
<p>Date : {current-date()}</p>



(: test xslt :)

{
  
  let $in :=
  db:open('igl_bibliography')//TEI
let $style :=
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
 
return xslt:transform($in, $style)
  
}




  <table>
    <thead>   
      <tr> 
        <td class="0">ref. bibl</td>
        <td class="1">Annee</td>
        <td class="2">Titre-ensemble</td>
        <td class="3">Numero volume</td>
        <td class="4">Titre</td>
        <td class="5">Titre-short</td>
        <td class="6">Collection</td>
        <td class="7">N° dans coll.</td>
        <td class="8">Auteur</td>
        <td class="note">Note</td>
        <td class="10">Lien</td>
      </tr>
    </thead>
    <tbody>
{for $bibl in db:open('igl_bibliography')//biblStruct[@type='book']
let $n := count($bibl)
let $id := $bibl/@id
let $monogr := $bibl/monogr[1]
let $titre-ensemble := $bibl/monogr[2]/title
let $volume := $bibl/monogr/imprint/biblScope
let $titre := $monogr/title[@level="m"][not(@type='short')]
let $titre-short := $monogr/title[@level="m"][@type='short']
let $annee := $monogr/imprint/date/@when
let $lien := $bibl/idno[@type='zotero-uri']
let $collection := $bibl/series
let $collNum := $collection/biblScope
let $note := $bibl/note
let $creators := $monogr/*[name()="author" or name()='editor' or  name()='respStmt']
let $espace := " "



(: partie pour trier:)
order by $titre-ensemble, $collection, $annee
(: fin tri :)

let $resp := for $i in $creators
let $isAuthor := $i/local-name()='author'


return 

<item org="{$i//name}" nom="{string($i//surname)}" prenom="{$i//forename}" role="{if ($isAuthor) then ('auteur') else() }{$i/@role|$i/resp}"/>


return

<result>

     <tr>
         <td class="0">{xslt:transform-text(<publicationStmt/>, 'variable.xsl')}</td>
        <td class="1">{string($annee)}</td>
        <td class="2">{data($titre-ensemble)}</td>    
        <td class="3">{data($volume)}</td>
 
        <td class="4">{data($titre)}</td>
        <td class="5">{data($titre-short)}</td>
        <td class="6">{data($collection/title)}</td>
        <td class="7">{data($collNum)}</td>       
        <td class="8">
        {for $item in $resp
            return <span class="resp">
             
              {data($item/@org)}
               {data($item/@nom)}
                 {$espace}
                 {data($item/@prenom)}
                 {$espace}
                <span class="role">({data($item/@role)})</span>
               
            </span>
           }
        </td>
        <td class="note">{data($note)}</td>
        <td class="10"><a href="{string($lien)}" title="{string($id)}" target='_blank'>vers Zot.</a></td>
      </tr>

  
</result>
}
    </tbody>
</table>

</div>
</body>
</html>