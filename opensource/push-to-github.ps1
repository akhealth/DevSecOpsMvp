# Pass these _hidden/encrypted_ parameters in from the build step
#  the "Arguments" look like `-user "$(gh-user)" -token "$(gh-access-token)" -repo "$(gh-repo)"`
Param(
  [string]$user,
  [string]$token,
  [string]$repo
)

# Force push to github using the access-token
$command = "git push https://${user}:${token}@github.com/$repo HEAD:master --force"
Invoke-Expression($command)