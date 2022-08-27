import Config

database = if System.get_env("DATABASE_URL"), do: nil, else: "ecto://postgres:root@localhost:5432/postgres?ssl=false"
hostname = if System.get_env("DATABASE_URL"), do: nil, else: "localhost"

# Configure your database
config :explorer, Explorer.Repo, timeout: :timer.seconds(80)

# Configure API database
config :explorer, Explorer.Repo.Replica1, timeout: :timer.seconds(80)

config :explorer, Explorer.Tracer, env: "dev", disabled?: true

config :logger, :explorer,
  level: :debug,
  path: Path.absname("logs/dev/explorer.log")

config :logger, :reading_token_functions,
  level: :debug,
  path: Path.absname("logs/dev/explorer/tokens/reading_functions.log"),
  metadata_filter: [fetcher: :token_functions]

config :logger, :token_instances,
  level: :debug,
  path: Path.absname("logs/dev/explorer/tokens/token_instances.log"),
  metadata_filter: [fetcher: :token_instances]

import_config "dev.secret.exs"

variant =
  if is_nil(System.get_env("ETHEREUM_JSONRPC_VARIANT")) do
    "besu"
  else
    System.get_env("ETHEREUM_JSONRPC_VARIANT")
    |> String.split(".")
    |> List.last()
    |> String.downcase()
  end

# Import variant specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "dev/#{variant}.exs"
