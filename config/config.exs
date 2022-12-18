import Config

config :ex_microsoft_teams, :tesla, http_adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
