package = "kong-auth-request-plugin"

version = "0.1.0-1"

supported_platforms = {"linux", "macosx"}

source = {
  url = "git+https://github.com/adrianorighi/kong-auth-request-plugin.git",
  branch = "main"
}

description = {
  summary = "A Kong plugin that make GET auth request before proxying the original.",
  homepage = "https://github.com/adrianorighi/kong-auth-request-plugin.git",
  license = "MIT"
}

dependencies = {
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.kong-auth-request-plugin.access"] = "src/access.lua",
    ["kong.plugins.kong-auth-request-plugin.handler"] = "src/handler.lua",
    ["kong.plugins.kong-auth-request-plugin.schema"] = "src/schema.lua"
  }
}
