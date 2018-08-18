vcl 4.0;

import std;
import bodyaccess;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "0.0.0.0";
    .port = "8080";
}

	sub vcl_recv {		
		if (req.method == "GET" && req.url ~ "(.*)/sparql\?(.*)(query=)") {
					set req.url = regsuball(req.url, "/sparql\?", "/test/query?");		
		 } else if (req.method == "POST") {
			std.cache_req_body(500KB);
			set req.http.X-Body-Len = bodyaccess.len_req_body();
			if (req.http.X-Body-Len == "-1") {
				return(synth(400, "The request body size exceeds the limit"));
			}
				
			if (bodyaccess.rematch_req_body("query=") == 1) {
				set req.url = regsuball(req.url, "/sparql", "/test/query");
			} else if (bodyaccess.rematch_req_body("update=") == 1) {
				set req.url = regsuball(req.url, "/sparql", "/test/update");
			}
			
			return (pass);
		}
		#std.log(req.url)
	}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}
