Mox.defmock(WoWData.Api.AccessTokenBehaviourMock, for: WoWData.Api.AccessTokenBehaviour)
Mox.defmock(WoWData.Api.ClientBehaviourMock, for: WoWData.Api.ClientBehaviour)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(WoWData.Repo, :manual)
