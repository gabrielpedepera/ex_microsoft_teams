# ex_microsoft_teams

Elixir library for integration with Microsoft Teams Incoming Webhook.

> We hope that the use of this library could be enjoyable despite the fact of dealing with Microsoft Teams.
  
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_microsoft_teams` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_microsoft_teams, "~> 0.1.0"}
  ]
end
```

## Usage

### Create a webhook in Microsoft Teams

    1. Navigate to the channel where you want to add the webhook and select (•••) Connectors from the top navigation bar.
    2. Search for Incoming Webhook, and add it.
    3. Click Configure and provide a name for your webhook.
    4. Copy the URL which appears and click "OK".

### Sending a message

```elixir
webhook_url = "https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456" 
message = "Hello World!!"
ExMicrosoftTeams.send_message(webhook_url, message)
=> {:ok, "Message sent!"}
```
or

```elixir
"https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456" 
|> ExMicrosoftTeams.client()
|> ExMicrosoftTeams.notify("Hello World!!")
=> {:ok, "Message sent!"}
```

## Testing

### Using [Mox](https://github.com/dashbitco/mox)

```elixir
# config/config.exs 
config :my_app, :microsoft_teams_client, ExMicrosoftTeams
```

```elixir
# microsoft_teams_client.ex, the main context we chose to call this function from
defmodule MicrosoftTeamsClient do
  def send_message(message) do
    microsoft_teams_client().send_message(webhook_url(), message)
  end

  defp webhook_url, do: "https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456"

  defp microsoft_teams_client do
    Application.compile_env(:my_app, :microsoft_teams_client)
  end
end
```

```elixir
# In your test/test_helper.exs
Mox.defmock(ExMicrosoftTeamsMock, for: ExMicrosoftTeams.Base) # <- Add this
Application.put_env(:my_app, :microsoft_teams_client, ExMicrosoftTeamsMock) # <- Add this

ExUnit.start()
```

```elixir
# test/microsoft_teams_client_test.exs
defmodule MicrosoftTeamsClientTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  describe "send_message/1" do
    test "send message with the correct webhook_url and message" do
      expect(ExMicrosoftTeamsMock, :send_message, fn webhook_url, message ->
        # here we can assert on the arguments that get passed to the function
        assert webhook_url == "https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456"
        assert message == "Hello World!"

        # here we decide what the mock returns
        {:ok, "Message sent!"}
      end)

      assert {:ok, _} = ExMicrosoftTeams.send_message("Hello World!")
    end
  end
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_microsoft_teams>.

