import Config

config :ex_microsoft_teams, :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
