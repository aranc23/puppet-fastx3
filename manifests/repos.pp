# create yum repositories, if configured
class fastx3::repos
{
  if $fastx3::manage_repos {
    create_resources('yum_repo', $fastx3::yum_repos)
  }
}
