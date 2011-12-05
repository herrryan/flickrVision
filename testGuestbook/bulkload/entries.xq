import module namespace guestbook = "http://www.28msec.com/templates/guestbook/guestbook";
import module namespace xqddf = "http://www.zorba-xquery.com/modules/xqddf";

let $entries := fn:doc("xml_files/recent.xml")//photo
return
    xqddf:insert-nodes(xs:QName("guestbook:photoentries"), $entries);