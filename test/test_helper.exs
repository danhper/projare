ExUnit.start

Mix.Task.run "ecto.create", ~w(-r CodecheckSprint.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r CodecheckSprint.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(CodecheckSprint.Repo)

