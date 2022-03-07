# create yum repositories, if configured
class fastx3::repos
{
  if $fastx3::manage_repos {
    create_resources('yumrepo', $fastx3::yumrepos)
  }
}
