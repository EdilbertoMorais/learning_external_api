ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)

Mox.defmock(MyApp.ViaCep.ClientMock, for: MyApp.ViaCep.Behaviour)
