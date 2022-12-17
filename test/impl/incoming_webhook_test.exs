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

      client = IncomingWebhook.client(webhook_url)

      assert {:ok, %Tesla.Env{body: "1"}} = Tesla.post(client, "/", "")
    end
  end

  describe "notify/2" do
    test "returns error when message is nil", %{webhook_url: webhook_url} do
      client = IncomingWebhook.client(webhook_url)

      assert {:error, "Message is required."} = IncomingWebhook.notify(client, nil)
    end
  end
end
