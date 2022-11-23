defmodule ExMicrosoftTeams do
  @moduledoc """
  Documentation for `ExMicrosoftTeams`.
  """

  alias ExMicrosoftTeams.Impl.HTTPClient

  @doc """
  Send a message to a specific channel accordingly the webhook_url

  ## Examples

      iex> ExMicrosoftTeams.send_message("https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456", "Hello World!!")
      {:ok, "1"}

  """
  @spec send_message(String.t(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defdelegate send_message(webhook_url, message), to: HTTPClient
end
