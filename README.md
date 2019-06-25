urllib
====
Web URL handling for D

Motivation
----------

[dhasenan's url library](https://github.com/dhasenan/urld) is great but I needed something more specific for web urls.

In particular, this library handles subdomains and tld.
Also, no implicit conversion to strings.

Usage
-----

Parse a URL:

```D
auto url = "ircs://irc.freenode.com/#d".parseURL;
```

Construct one from scratch, laboriously:

```D
URL url;
with (url) {
	scheme = "soap.beep";
	host = "example";
    tld = "org";
    subdomain = "beep";
	port = 1772;
	path = "/serverinfo/info";
  queryParams.add("token", "my-api-token");
}
curl.get(url.toString);
```

Unicode domain names:

```D
auto url = "http://☃.com/".parseURL;
writeln(url.toString);               // http://xn--n3h.com/
writeln(url.toHumanReadableString);  // http://☃.com/
```

Autodetect ports:

```D
assert(parseURL("http://example.org").port == 80);
assert(parseURL("http://example.org:5326").port == 5326);
```

URLs of maximum complexity:

```D
auto url = parseURL("redis://admin:password@redisbox.local:2201/path?query=value#fragment");
assert(url.scheme == "redis");
assert(url.user == "admin");
assert(url.pass == "password");
// etc
```

URLs of minimum complexity:

```D
assert(parseURL("example.org").toString == "http://example.org/");
```

Canonicalization:

```D
assert(parseURL("http://example.org:80").toString == "http://example.org/");
```
