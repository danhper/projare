defmodule Projare.CommentView do
  use Projare.Web, :view

  def render("index.json", %{comments: comments}) do
    render_many(comments, Projare.CommentView, "comment.json")
  end

  def render("show.json", %{comment: comment}) do
    render_one(comment, Projare.CommentView, "comment.json")
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body,
      inserted_at: comment.inserted_at,
      author: render_one(comment.author, Projare.UserView, "user.json")}
  end
end
