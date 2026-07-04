defmodule UOF.API.Users do
  @moduledoc """
  API used for administrative purposes.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get information about the token being used, including information such as
  the caller's bookmaker id and when the caller's access token will expire.
  """
  def whoami do
    endpoint = ["users", "whoami.xml"]

    HTTP.get(endpoint)
  end
end
