local typedefs = require "kong.db.schema.typedefs"

return {
    name = "kong-auth-request-plugin",
    fields = {
        { consumer = typedefs.no_consumer },
        { config = {
            type = "record",
            fields = {
                { timeout = {
                    type = "number",
                    required = true,
                    default = 60000,
                    description = "An optional timeout in milliseconds when invoking the function.",
                } },
                { auth_uri = {
                    type = "string",
                    referenceable = true,
                    description = "The URL to auth validate request.",
                } },
                { origin_request_headers_to_forward_to_auth = {
                    type = "array",
                    elements = {
                        type = "string",
                    },
                    referenceable = true,
                    description = "The headers to forward to auth validate request (Authorization, x-api-key, etc.).",
                } },
            }
        } }
    }
}