defmodule ExMicrosoftTeams.Impl.IncomingWebhook do
  def client(webhook_url, opts \\ []) do
    adapter = Keyword.get(opts, :adapter, Tesla.Adapter.Hackney)

    middleware = [
      {Tesla.Middleware.BaseUrl, webhook_url},
      {Tesla.Middleware.Headers, [{"Content-Type", "application/json"}]},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]}
    ]

    Tesla.client(middleware, adapter)
  end

  def notify(_client, nil) do
    {:error, "A message is required."}
  end

  def notify(client, message) do
    case Tesla.post(client, "/", %{text: message}) do
      {:ok, %Tesla.Env{body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end
end
