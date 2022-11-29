defmodule ExMicrosoftTeams.Impl.IncomingWebhookTest do
  use ExUnit.Case

  import Tesla.Mock

  alias ExMicrosoftTeams.Impl.IncomingWebhook

  setup do
    webhook_url = "https://microsoft-teams.com/incoming-webhook/42"

    mock(fn
      %{method: :post, url: ^webhook_url} ->
        %Tesla.Env{status: 200, body: "1"}
    end)

    {:ok, webhook_url: webhook_url}
  end

  describe "client/2" do
    test "returns a client with the URL set properly", %{webhook_url: webhook_url} do
      client = IncomingWebhook.client(webhook_url)

      assert Enum.member?(client.pre, {Tesla.Middleware.BaseUrl, :call, [webhook_url]}) == true
    end

    test "returns a client with the adapter set properly", %{webhook_url: webhook_url} do
      adapter = Tesla.Adapter.Mint
      client = IncomingWebhook.client(webhook_url, adapter: adapter)

      assert client.adapter == {adapter, :call, [[]]}
    end
  end
end
