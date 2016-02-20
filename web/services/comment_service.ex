defmodule Projare.CommentService do
  use Projare.Web, :service

  alias Projare.Project

  def create_comment(changeset, project) do
    {:ok, result} = Repo.transaction fn ->
      project |> comments_count_changeset(1) |> Repo.update!
      Repo.insert(changeset)
    end
    result
  end

  def delete_comment!(changeset, project) do
    Repo.transaction fn ->
      project |> comments_count_changeset(-1) |> Repo.update!
      Repo.delete!(changeset)
    end
  end

  defp comments_count_changeset(project, delta) do
    Project.comment_changeset(project, %{comments_count: project.comments_count + delta})
  end
end
