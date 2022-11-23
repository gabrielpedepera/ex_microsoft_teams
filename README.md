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

### Send a message

```elixir
webhook_url = "https://acme.webhook.office.com/webhookb2/abc/IncomingWebhook/123/456" 
message = "Hello World!!"
ExMicrosoftTeams.send_message(webhook_url, message)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_microsoft_teams>.

