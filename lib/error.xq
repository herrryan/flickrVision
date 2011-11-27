module namespace err = "http://www.example.com/flickrVision/lib/error";

import module namespace http="http://www.28msec.com/modules/http";
import module namespace cookie="http://www.28msec.com/modules/http/cookie";

declare function err:show($status, $msg, $stack)
{
  <html>
      <head>
          <title> { $status } - Oups... An error happened</title>
      </head>
    <body style='font: 100% "Lucida Grande", tahoma, verdana, arial, sans-serif !important; margin: 20px;'>
      <center><h1>Oups... An error happened</h1>
        <table>
          {
            if ( $status eq 404 ) then (
              <tr height="50"><td colspan="2">The requested URL was not found on this server ({ $status }).</td></tr>,
              <tr><td valign="top"><b>Reason:</b></td><td> { $msg }</td></tr>,
              <tr height="50"><td colspan="2">If you were trying to access the project's default handler visit <a href="/default/index">/default/index</a>. If you think this is an error, please contact <a href="mailto:support@28msec.com">support@28msec.com</a>.</td></tr>
            )
            else (
              <tr valign="top" height="50"><td><b>Status:</b></td><td>{ $status }</td></tr>,
              <tr valign="top"><td><b>Message:</b></td><td>{ $msg }</td></tr>
            )
          }
        </table>
      </center>
      <p>
        <hr />
        <h2>Stack Trace: </h2>
        {
          for $call in $stack/stack/call
          let $ns    := string($call/@ns)
          let $name  := string($call/@localName)
          let $arity := string($call/@arity)
          return (<code>called from module <b>{$ns}</b> function <b>{$name}#{$arity}</b></code>,<br/>)
        } 
      </p>
      <p> 
        <hr/>
        <h2> Request Information: </h2>
        <table>
          <tr>
            <td>Request Method: </td><td>{ http:get-method() }</td>
          </tr>
          <tr>
            <td>Content-Type:</td><td>{ http:get-content-type() }</td>
          </tr>
          <tr>
            <td>Remote Port:</td><td>{ http:get-remote-port() }</td>
          </tr>
          <tr>
            <td>Remote Address:</td><td>{ http:get-remote-addr() }</td>
          </tr>
          <tr>
            <td>Query String:</td><td>{ http:get-query-string() }</td>
          </tr>
          <tr>
            <td>User Agent:</td><td>{ http:get-user-agent() }</td>
          </tr>
          <tr>
            <td>HTTP Accept Header:</td><td>{ http:get-header("HTTP_ACCEPT") }</td>
          </tr>
          <tr>
            <td width="200">All Header Names</td><td>{ http:get-header-names() }</td>
          </tr>
          {
          let $params := http:get-parameter-names()
          return
            if (fn:exists($params)) then
              <tr>
                <td valign="top">Request Parameters:</td>
                <td>
                  <table border="0">
                    <tr><td><b>Name</b></td><td><b>Value</b></td></tr>
                    {
                        for $param in $params
                        let $values := http:get-parameters($param)
                        for $value in $values
                        return 
                          <tr>
                            <td>{$param}</td>
                            <td>{$value}</td>
                          </tr>
                    }
                  </table>
                </td>
              </tr>
            else (),
          
          let $cookies := cookie:get-cookies(())
          return
            if (fn:exists($cookies)) then
              <tr>
                <td valign="top">Cookies:</td>
                <td>
                  <table border="0">
                    <tr><td><b>Name</b></td><td><b>Value</b></td></tr>
                    {
                      for $cookie in $cookies
                      return 
                        <tr>
                          <td>{$cookie/data(@name)}</td>
                          <td>{$cookie/child::node()}</td>
                        </tr>
                    }
                  </table>
                </td>
              </tr>
            else ()
          }
        </table>
        <hr/>
      </p>
    </body>
  </html>
};
