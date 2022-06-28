defmodule Hello.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Hello.Repo

  alias Hello.Accounts.{User, Credential}

  @doc false
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:credential)
  end

  @doc false
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:credential)
  end

  @doc false
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert()
  end

  @doc false
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.update()
  end

  @doc false
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc false
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc false
  def list_credentials do
    Repo.all(Credential)
  end

  @doc false
  def get_credential!(id), do: Repo.get!(Credential, id)

  @doc false
  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  @doc false
  def change_credential(%Credential{} = credential, attrs \\ %{}) do
    Credential.changeset(credential, attrs)
  end

  def authenticate_by_email_password(email, _password) do
    query =
      from u in User,
          inner_join: c in assoc(u, :credential),
          where: c.email == ^email

    case Repo.one(query) do
      %User{}=user -> {:ok, user}
      nil -> {:error, :unauthorized}
    end
  end
end
