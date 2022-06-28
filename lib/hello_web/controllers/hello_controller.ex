defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => _messenger}) do
    conn
    |> put_layout("admin.html")
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> render("show.html", messenger: messenger)
    |> redirect(to: Routes.hello_path(conn, :index))
  end

end
