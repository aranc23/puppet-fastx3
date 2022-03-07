# create yum repositories, if configured
class fastx3::repos
{
    create_resources('yum_repo', $fastx3::yum_repos)
}
