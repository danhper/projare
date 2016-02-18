defmodule CodecheckSprint.ProjectService do
  use CodecheckSprint.Web, :service

  alias CodecheckSprint.Project
  alias CodecheckSprint.User
  alias CodecheckSprint.Star
  alias CodecheckSprint.Comment

  def assign_starred(%Project{} = project, user) do
    assign_starred([project], user) |> List.first
  end

  def assign_starred(projects, %User{} = user) do
    stars = Star |> Star.for_user(user) |> Star.for_projects(projects) |> Repo.all
    starred_project_ids = Enum.map(stars, &(&1.project_id)) |> Enum.into(MapSet.new)
    Enum.map projects, fn project ->
      %{project | starred: MapSet.member?(starred_project_ids, project.id)}
    end
  end
  def assign_starred(projects, _), do: Enum.map projects, &(%{&1 | starred: false})

  def assign_commented(%Project{} = project, user) do
    assign_commented([project], user) |> List.first
  end

  def assign_commented(projects, %User{} = user) do
    comments = Comment |> Comment.for_user(user) |> Comment.for_projects(projects) |> Repo.all
    commented_project_ids = Enum.map(comments, &(&1.project_id)) |> Enum.into(MapSet.new)
    Enum.map projects, fn project ->
      %{project | commented: MapSet.member?(commented_project_ids, project.id)}
    end
  end
  def assign_commented(projects, _), do: Enum.map projects, &(%{&1 | commented: false})

  def star_project(%Project{} = project, %User{} = user) do
    if not is_nil(get_star(project, user)) do
      {:error, 400, "already starred"}
    else
      add_star(project, user) |> handle_star_result
    end
  end

  def unstar_project(%Project{} = project, %User{} = user) do
    if star = get_star(project, user) do
      remove_star(project, star) |> handle_star_result
    else
      {:error, 400, "not starred"}
    end
  end

  defp handle_star_result({:ok, _}), do: :ok
  defp handle_star_result(_), do: {:error, 500, "failed to star project"}

  defp add_star(project, user) do
    Repo.transaction fn ->
      Repo.insert(%Star{project_id: project.id, user_id: user.id})
      Repo.update(star_changeset(project, 1))
    end
  end

  defp remove_star(project, star) do
    Repo.transaction fn ->
      Repo.delete!(star)
      Repo.update!(star_changeset(project, -1))
    end
  end

  defp star_changeset(project, delta) do
    Project.star_changeset(project, %{stars_count: project.stars_count + delta})
  end

  defp get_star(project, user) do
    Repo.get_by(Star, user_id: user.id, project_id: project.id)
  end
end
