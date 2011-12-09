(:
 : Copyright 2010 28msec Inc.
 :)

module namespace guestbook = "http://www.28msec.com/templates/guestbook/guestbook";

import module namespace http = "http://www.28msec.com/modules/http";

import module namespace xqddf = "http://www.zorba-xquery.com/modules/xqddf";
import module namespace zorba-rest = "http://www.zorba-xquery.com/zorba/rest-functions";

declare collection guestbook:photoentries as node()*;
declare collection guestbook:photos as node()*;

declare variable $guestbook:entries as xs:QName := xs:QName("guestbook:photos");

declare sequential function guestbook:add()
{
  http:set-header("Cache-Control", "no-cache");
  xqddf:insert-nodes(
      $guestbook:entries,
      <entry author="{http:get-parameters("author")}" date="{fn:current-date()}" time="{fn:current-time()}">
      {
        http:get-parameters("text")
      }
      </entry>
  );
  exit returning guestbook:listshs();
};

declare sequential function guestbook:listshs() {
  
  http:set-content-type("application/xml");
  let $entries := zorba-rest:get("http://www.flickr.com/services/rest/?method=flickr.photos.getRecent&amp;api_key=b9a678af037005a87cc46dbb9bed702b")//photo
  let $num_entries := fn:count($entries)
  return 
    if($num_entries = 0)
    then
      <div class="entry"><b>No entries, yet.</b></div>
    else
      for $entry in $entries
      (:"let $numbering := if ($num_entries lt 5) then $pos else $num_entries - ( 5 - $pos):)
      let $location := zorba-rest:get(fn:concat("http://www.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&amp;api_key=b9a678af037005a87cc46dbb9bed702b&amp;photo_id=", string($entry/@id)))//location
      let $photo_url := fn:concat("http://farm", string($entry/@farm), ".staticflickr.com/", string($entry/@server), "/", string($entry/@id), "_", string($entry/@secret), "_t.jpg")

      return
      if (fn:count($location) != 0)
      then
             <entry>
                 <id>{string($entry/@id)}</id>
                 <latitude>{string($location/@latitude)}</latitude>
                 <longtitude>{string($location/@longitude)}</longtitude>
                 <photo>{$photo_url}</photo>
             </entry>
      else
      ();
};

declare sequential function guestbook:insert() {
     xqddf:insert-nodes($guestbook:entries, zorba-rest:get("http://www.flickr.com/services/rest/?method=flickr.photos.getRecent&amp;api_key=b9a678af037005a87cc46dbb9bed702b")//photo);
};