(: XQuery main module :)



    for $photo in doc("rest.xml")/photos/photo
        let $photo_id := $photo/id
        return
            <photo_ids>
                $photo_id
            </photo_ids>



