local http = require "resty.http"

local _M = {}

function _M.execute(conf)
    local scheme, host, port, _ = unpack(http:parse_uri(conf.auth_uri))

    local client = http.new()
    client:set_timeout(conf.timeout)
    client:connect(host, port)

    local auth_request = _M.new_auth_request(conf.origin_request_headers_to_forward_to_auth, conf.keepalive_timeout)

    local res, err = client:request_uri(conf.auth_uri, auth_request)

    if not res then
        kong.log.err(err)
        return kong.response.exit(500, { message = "An unexpected error occurred (REQUEST)" })
    end

    if res.status > 299 then
        return kong.response.exit(res.status, res.body)
    end
end

function _M.new_auth_request(origin_request_headers_to_forward_to_auth, keepalive_timeout)
    local headers = {
        charset = "utf-8",
        ["content-type"] = "application/json"
    }
    
    for _, name in ipairs(origin_request_headers_to_forward_to_auth) do
        local header_val = kong.request.get_header(name)
        if header_val then
            headers[name] = header_val
        end
    end

    return {
        method = "GET",
        headers = headers,
        body = "",
        keepalive_timeout = keepalive_timeout
    }
end

return _M
