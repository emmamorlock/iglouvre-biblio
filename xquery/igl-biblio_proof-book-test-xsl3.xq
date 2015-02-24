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
 <biblStruct type="book" xml:id="Łajtar2003a">
                    <monogr>
                        <title level="m">Khartoum Greek</title>
                        <title level="m" type="short">I.Khartoum</title>
                        <author><forename>Adam</forename><surname>Łajtar</surname></author>
                        <imprint>
                            <pubPlace>Louvain, Belgique</pubPlace>
                            <biblScope unit="volume">I</biblScope>
                            <publisher>Peeters and Departement Oosterse Studies</publisher>
                            <date when="2003"/>
                        </imprint>
                    </monogr>
                    <series><title level="s">Orientalia Lovaniensia analecta</title><biblScope
                            unit="volume">122</biblScope></series>
                    <monogr>
                        <title>Catalogue of the Greek Inscriptions in the Sudan National Museum at
                            Khartoum</title>
                        <imprint>
                            <biblScope/>
                        </imprint>
                    </monogr>
                    <idno type="ISBN">90-429125-29</idno>
                    <idno type="callNumber">$</idno>
                    <idno type="zotero-uri">http://zotero.org/groups/248770/items/22HVPMSW</idno>
                    <idno type="archiveLocation">I-Khartoum</idno>
                </biblStruct>
  let $style := doc('../xsl/iglouvre-biblio-controle.xsl')
 
return (xslt:transform($in, $style) )
  
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
        <td class="0">{xslt:transform-text(<publicationStmt/>, 'basic.xsl')}</td>
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