defmodule HelloWeb.UserView do
  use HelloWeb, :view

  alias Hello.Accounts.User

  def credential_email(%User{credential: nil}), do: nil
  def credential_email(%User{credential: credential}), do: credential.email
end
