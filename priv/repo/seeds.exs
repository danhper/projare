alias Projare.Repo
alias Projare.Category

categories = [%{name: "JavaScript", normalized_name: "javascript", icon: "devicon-javascript-plain"},
              %{name: "PHP", normalized_name: "php", icon: "devicon-php-plain"},
              %{name: "Ruby", normalized_name: "ruby", icon: "devicon-ruby-plain"},
              %{name: "iOS", normalized_name: "ios", icon: "devicon-apple-original"},
              %{name: "Android", normalized_name: "android", icon: "devicon-android-plain"},
              %{name: "Python", normalized_name: "python", icon: "devicon-python-plain"},
              %{name: "HTML", normalized_name: "html", icon: "devicon-html5-plain"},
              %{name: "CSS", normalized_name: "css", icon: "devicon-css3-plain"},
              %{name: "Go", normalized_name: "go", icon: "devicon-go-plain"},
              %{name: "Java", normalized_name: "java", icon: "devicon-java-plain"},
              %{name: "Linux", normalized_name: "linux", icon: "devicon-linux-plain"},
              %{name: "Windows", normalized_name: "windows", icon: "devicon-windows8-original"},
              %{name: "Erlang", normalized_name: "erlang", icon: "devicon-erlang-plain"},
              %{name: "C#", normalized_name: "csharp", icon: "devicon-csharp-plain"},
              %{name: "C++", normalized_name: "cpp", icon: "devicon-cplusplus-plain"}]


Enum.each categories, fn category ->
  if is_nil(Repo.get_by(Category, normalized_name: category.normalized_name)) do
    struct(Category, category) |> Repo.insert!
  end
end
