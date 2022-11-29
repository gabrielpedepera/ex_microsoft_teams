defmodule ExMicrosoftTeams.Impl.IncomingWebhookTest do
  use ExUnit.Case

  import Mox

  alias ExMicrosoftTeams.Impl.IncomingWebhook

  setup do
    webhook_url = "https://microsoft-teams.com/incoming-webhook/42/"

    {:ok, webhook_url: webhook_url}
  end

  describe "client/2" do
    test "returns a client with the webhook URL set properly", %{webhook_url: webhook_url} do
      Tesla.MockAdapter
      |> expect(:call, fn
        %{url: ^webhook_url}, _opts ->
          {:ok, %Tesla.Env{status: 200, body: "1"}}
      end)

      client = IncomingWebhook.client(webhook_url, adapter: Tesla.MockAdapter)

      assert {:ok, %Tesla.Env{body: "1"}} = Tesla.post(client, "/", "")
    end

    test "returns a client with the adapter set properly", %{webhook_url: webhook_url} do
      adapter = Tesla.Adapter.Mint
      client = IncomingWebhook.client(webhook_url, adapter: adapter)

      assert adapter == Tesla.Client.adapter(client)
    end
  end
end
