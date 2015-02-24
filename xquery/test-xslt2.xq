(: test xslt :)
(: Outputs the result as html. :)
declare option output:method 'html';
(: Turn whitespace chopping off. :)
declare option db:chop 'no';
 
let $in :=  db:open('igl_bibliography')//TEI
let $style := doc('variable.xsl')
 
return (xslt:transform($in, $style))
