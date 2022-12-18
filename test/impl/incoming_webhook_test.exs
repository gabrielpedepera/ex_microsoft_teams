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
    test "returns error when client is nil" do
      assert {:error, "Client is required"} = IncomingWebhook.notify(nil, "The Message")
    end

    test "returns error when message is nil", %{webhook_url: webhook_url} do
      client = IncomingWebhook.client(webhook_url)

      assert {:error, "Message is required"} = IncomingWebhook.notify(client, nil)
    end

   test "returns a ok when the request is successfully", %{webhook_url: webhook_url} do
      Tesla.MockAdapter
      |> expect(:call, fn
        %{url: ^webhook_url}, _opts ->
          {:ok, %Tesla.Env{status: 200, body: "1"}}
      end)

      client = IncomingWebhook.client(webhook_url)

      assert {:ok, "1"} = IncomingWebhook.notify(client, "The Message")
    end

    test "returns error when request fails", %{webhook_url: webhook_url} do
      Tesla.MockAdapter
      |> expect(:call, fn
        %{url: ^webhook_url}, _opts ->
          {:error, %Tesla.Env{status: 400, body: "Request failed"}}
      end)

      client = IncomingWebhook.client(webhook_url)

      assert {:error, "Request failed"} = IncomingWebhook.notify(client, "The Message")
    end

    test "returns error when request does not have any response", %{webhook_url: webhook_url} do
      Tesla.MockAdapter
      |> expect(:call, fn
        %{url: ^webhook_url}, _opts ->
          {:error, "Unexpected Error"}
      end)

      client = IncomingWebhook.client(webhook_url)

      assert {:error, "\"Unexpected Error\""} = IncomingWebhook.notify(client, "The Message")
    end
  end
end
