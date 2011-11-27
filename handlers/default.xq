(: This is the default handler module created for an empty project. :)

(:
  module namespace explanation:
  -------------------------------------
		the module namespace consists of the base project uri (see .config/sausalito.xml) plus the module
		handler name (that is equal to the .xq file name)
:)
module namespace fv = "http://www.example.com/flickrVision/default";

import module namespace http="http://www.28msec.com/modules/http";

import module namespace xqddf = "http://www.zorba-xquery.com/modules/xqddf";

declare collection fv:photos as node()*;
declare variable $fv:photos as xs:QName := xs:QName("fv:photos");


declare sequential function fv:getid(){

for $photo in xqddf:collection($fv:photos)//photo
    let $photo_id := $photo/id
    return
        <div>
            {$photo_id}
        </div>
};
