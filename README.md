# kong-auth-request-plugin

A Kong plugin that make GET auth request before proxying the original request.

## Description

Plugin takes GET http request with Authorization header and send it to auth service (url is taken from plugin  configuration), then if auth response status code is 200 then plugin routes original request to upstream service with headers (header names are taken from plugin configuration) from auth response.
If auth response code is greater than 299 then auth response is returned to client and origin request is not passed to upstream.

## Installation

Requirements:

- Lua: `apt install lua5.3`
- Lua-dev: `apt install liblua5.3-dev`

Make package.

```luarocks make```

```luarocks pack kong-auth-request-plugin 0.1.0-1```

Install plugin by luarocks package manager.  
```luarocks install kong-auth-request-plugin```

Add kong-auth-request-plugin to Kong by environment variable
```KONG_PLUGINS=bundled,kong-auth-request-plugin```

or add it to kong.conf:  
```plugins = bundled,kong-auth-request-plugin```

## Configuration

```
curl -X POST \
--url "http://kong:8001/services/{id}/plugins" \
--data "name=kong-auth-request-plugin" \
--data "config.auth_uri=http://auth.url/v1/auth" \
--data "config.origin_request_headers_to_forward_to_auth[]=Authorization"
```

config parameter | description
-----------------|--------------
config.auth_uri  | Plugin make a HTTP GET request with Authorization header to this URL before proxying the original request
config.origin_request_headers_to_forward_to_auth | Origin request headers to pass to auth uri (ex. Authorization, x-api-key)

## Kong docs

https://docs.konghq.com/gateway/latest/plugin-development/

## Author

Adriano Righi