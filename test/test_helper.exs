Mox.defmock(WoWData.Api.ClientBehaviourMock, for: WoWData.Api.ClientBehaviour)
Mox.defmock(WoWData.Api.AccessTokenBehaviourMock, for: WoWData.Api.AccessTokenBehaviour)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(WoWData.Repo, :manual)
