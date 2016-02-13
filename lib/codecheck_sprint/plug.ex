defmodule CodecheckSprint.Plug do
  def signed_in?(conn) do
    not is_nil(current_user(conn))
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end
end
