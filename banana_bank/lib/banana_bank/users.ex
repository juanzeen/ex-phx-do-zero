defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  #vou delegar a função create, recebendo params para o módulo create com a função call
  defdelegate create(params), to: Create, as: :call
end
