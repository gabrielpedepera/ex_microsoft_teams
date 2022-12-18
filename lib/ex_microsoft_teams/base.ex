defmodule ExMicrosoftTeams.Base do
  alias ExMicrosoftTeams.IncomingWebhook

  @type client :: Tesla.Client.t()
  @type webhook_url :: String.t()
  @type message :: String.t()

  @callback send_message(webhook_url, message) :: {:ok, String.t()} | {:error, String.t()}
  @callback client(webhook_url) :: client
  @callback notify(client, message) :: {:ok, String.t()} | {:error, String.t()}

  defmacro __using__(_) do
    quote do
      @behaviour ExMicrosoftTeams.Base

      alias ExMicrosoftTeams.Base

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
      @spec client(Base.webhook_url()) :: Base.client()
      defdelegate client(webhook_url), to: IncomingWebhook

      @doc """
      Send a message to a specific channel accordingly the client

      ## Examples

         iex> client = ExMicrosoftTeams.client("https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456")
         iex> ExMicrosoftTeams.notify(client, "Hello World!")
         {:ok, "1"}
      """

      @spec notify(Base.client(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
      defdelegate notify(client, message), to: IncomingWebhook
    end
  end
end
