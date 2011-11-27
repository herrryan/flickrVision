module namespace fv = "http://www.example.com/flickrVision/default";

import module namespace http="http://www.28msec.com/modules/http";

import module namespace xqddf = "http://www.zorba-xquery.com/modules/xqddf";

let $photos := fn:doc("../xml_files/rest.xml")
return
    xqddf:insert-nodes(xs:QName("fv:photos"), $photos)