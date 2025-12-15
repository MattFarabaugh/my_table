defmodule MyTableWeb.PageController do
  use MyTableWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
