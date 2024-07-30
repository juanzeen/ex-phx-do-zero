defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  alias BananaBank.Users.Get
  #vou delegar a função create, recebendo params para o módulo create com a função call
  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
