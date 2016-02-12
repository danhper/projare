defmodule CodecheckSprint.UserView do
  use CodecheckSprint.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, CodecheckSprint.UserView, "user.json")
  end

  def render("show.json", %{user: user} = opts) do
    if opts[:full] do
      render_one(user, CodecheckSprint.UserView, "full_user.json")
    else
      render_one(user, CodecheckSprint.UserView, "user.json")
    end
  end

  def render("login_error.json", _params) do
    %{error: "Invalid email or password"}
  end

  def render("full_user.json", %{user: user} = params) do
    Map.merge(render("user.json", params), %{
      email: user.email,
      secret_token: user.secret_token
    })
  end
  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      image_url: Exgravatar.gravatar_url(user.email, s: 256)}
  end
end
