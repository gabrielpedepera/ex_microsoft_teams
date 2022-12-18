defmodule ExMicrosoftTeams.Impl.IncomingWebhook do
  @adapter Application.compile_env(:ex_microsoft_teams, :tesla)[:http_adapter]

  def client(webhook_url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, webhook_url},
      {Tesla.Middleware.Headers, [{"Content-Type", "application/json"}]},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]}
    ]

    Tesla.client(middleware, @adapter)
  end

  def notify(_client, nil) do
    {:error, "message is required"}
  end

  def notify(nil, _message) do
    {:error, "client is required"}
  end

  def notify(client, message) do
    case Tesla.post(client, "", %{text: message}) do
      {:ok, %Tesla.Env{body: body}} ->
        {:ok, body}

      {:error, %Tesla.Env{body: body}} ->
        {:error, body}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  def send_message(webhook_url, message) do
    webhook_url
    |> client()
    |> notify(message)
  end
end
