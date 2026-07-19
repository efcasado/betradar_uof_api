defmodule UOF.API.Users do
  @moduledoc """
  API used for administrative purposes.

  Functions return `{:ok, response} | {:error, UOF.API.Error.t()}`.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get information about the token being used, including information such as
  the caller's bookmaker id and when the caller's access token will expire.

  The trailing `opts` is a keyword list merged into the Req request (see
  `UOF.API.Utils.HTTP`).
  """
  def whoami(opts \\ []) do
    endpoint = ["users", "whoami.xml"]

    HTTP.get(endpoint, [], opts)
  end
end
