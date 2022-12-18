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
  defdelegate send_message(webhook_url, message), to: IncomingWebhook

  @doc """
  Dynamically build client from a incoming webhook_url.

  ## Examples

     iex> ExMicrosoftTeams.client("https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456")
     %Tesla.Client{
       fun: nil,
       pre: [
         {Tesla.Middleware.BaseUrl, :call,
          ["https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456"]},
         {Tesla.Middleware.Headers, :call, [[{"Content-Type", "application/json"}]]},
         {Tesla.Middleware.JSON, :call,
          [[engine: Jason, engine_opts: [keys: :atoms]]]}
       ],
       post: [],
       adapter: nil
     }
  """
  @spec client(String.t()) :: client
  defdelegate client(webhook_url), to: IncomingWebhook

  @doc """
  Send a message to a specific channel accordingly the client

  ## Examples

     iex> client = ExMicrosoftTeams.client("https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456")
     iex> ExMicrosoftTeams.notify(client, "Hello World!")
     {:ok, "1"}
  """

  @spec notify(client, String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defdelegate notify(client, message), to: IncomingWebhook
end
