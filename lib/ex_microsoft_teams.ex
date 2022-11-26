defmodule ExMicrosoftTeams do
  @moduledoc """
  Documentation for `ExMicrosoftTeams`.
  """

  @opaque client :: Tesla.Client.t()

  alias ExMicrosoftTeams.Impl.IncomingWebhook

  @doc """
  Send a message to a specific channel accordingly the webhook_url

  ## Examples

      iex> ExMicrosoftTeams.send_message("https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456", "Hello World!!")
      {:ok, "1"}

  """
  @spec send_message(String.t(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def send_message(webhook_url, message) do
    webhook_url
    |> IncomingWebhook.client()
    |> IncomingWebhook.notify(message)
  end

  @spec client(String.t()) :: client
  defdelegate client(webhook_url), to: IncomingWebhook

  @spec notify(client, String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defdelegate notify(client, message), to: IncomingWebhook
end
