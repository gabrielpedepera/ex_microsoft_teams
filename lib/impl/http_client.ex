defmodule ExMicrosoftTeams.Impl.HTTPClient do
  @moduledoc "Implementation to send messages to Microsoft Teams"
  use Tesla

  plug(Tesla.Middleware.Headers, [{"Content-Type", "application/json"}])
  plug(Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms])

  def send_message(nil, _message) do
    {:error, "The Webhook URL is required."}
  end

  def send_message(_web_hook_url, nil) do
    {:error, "A message is required."}
  end

  def send_message(webhook_url, message) do
    case channel_notification(webhook_url, message) do
      {:ok, body} ->
        {:ok, body}

      {:error, message} ->
        {:error, message}
    end
  end

  defp channel_notification(webhook, message) do
    case post(webhook, payload(message)) do
      {:ok, %Tesla.Env{body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  defp payload(message) do
    %{text: message}
  end
end
