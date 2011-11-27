(: This is the default handler module created for an empty project. :)

(:
  module namespace explanation:
  -------------------------------------
		the module namespace consists of the base project uri (see .config/sausalito.xml) plus the module
		handler name (that is equal to the .xq file name)
:)
module namespace def = "http://www.example.com/flickrVision/default";

import module namespace http="http://www.28msec.com/modules/http";
import module namespace cookie="http://www.28msec.com/modules/http/cookie";

declare sequential function def:index ()
{
  cookie:set-cookie(<cookie:cookie name='myCookie'>myValue</cookie:cookie>),
  <html>
    <head>
      <title>The project default handler</title>
    </head>
    <body style='font: 100% "Lucida Grande", tahoma, verdana, arial, sans-serif !important; margin: 20px;'>
      <center><h1>Default Sausalito Handler</h1></center>
      This page was generated by the project's <b>default</b> handler.
      Change the body of this function to implement your own
      functionality.<br />
      Please take a look at <a href="/default/post">def:post()</a> to see how Sausalito access HTTP parameters.
      <br/><br/>
      <hr/>
      <h1> Request Information: </h1>
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
          <td width="200">All Header Names:</td><td>{ http:get-header-names() }</td>
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
    </body>
  </html>
};

declare function def:post()
{
  <html>
    <head>
      <title>The Post Example</title>
    </head>
    <body style='font: 100% "Lucida Grande", tahoma, verdana, arial, sans-serif !important; margin: 20px;'>
      <center><h1>Default Sausalito Handler</h1></center>
      This page was generated by the project's <b>default</b> handler.
      It demonstrates post parameters.<br/>
      Add values into the form an click <i>Send</i>.
      <br/><br/>
      <hr/>
      <h1> Form: </h1>
      <form action="index" method="post">
        <table>
          <tr>
            <td>First:</td><td><input type="text" name="first" /></td>
          </tr>
          <tr>
            <td>Second:</td><td><input type="textarea" name="second" /></td>
          </tr>
          <tr>
            <td>Third:</td>
            <td>
              <select name="third">
                <option>first_entry</option>
                <option>second_entry</option>
                <option>thrid_entry</option>
                <option>fourth_entry</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Forth:</td>
            <td>
              <select name="fourth" multiple="true">
                <option>first entry</option>
                <option>second entry</option>
                <option>third entry</option>
                <option>forth entry</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>Fifth:</td>
            <td>
              <input type="radio" name="fifth" value="milk">Milk</input><br/>
              <input type="radio" name="fifth" value="butter">Butter</input><br/>
              <input type="radio" name="fifth" value="cheese" checked="true">Cheese</input><br/>
              <input type="radio" name="fifth" value="water">Water</input>
            </td>
          </tr>
          <tr>
            <td>Sixth:</td>
            <td>
              <input type="checkbox" name="sixth" value="soccer">Soccer</input><br />
              <input type="checkbox" name="sixth" value="football">Football</input>
            </td>
          </tr>
          <tr>
            <td></td><td><input type="submit" value="Send" /></td>
          </tr>
        </table>
      </form>
      <hr/>
    </body>
  </html>
};