local access = require "kong.plugins.kong-auth-request-plugin.access"
local kong = kong

local AuthRequestHandler = {
  VERSION  = "1.0.0",
  PRIORITY = 1020,
}

function AuthRequestHandler:init()
  kong.new(self, "kong-auth-request-plugin")
end

function AuthRequestHandler:access(conf)
  if not conf.auth_uri then
    return error("no auth_uri specified")
  end
  access.execute(conf)
end

return AuthRequestHandler