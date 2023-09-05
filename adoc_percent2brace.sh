# loop over all strings to replace
#
declare -a arr=(
"preconfigure_aad"
"aro_kube_password"
"aro_console"
"aro_api"
"aro_clientid"
"az_aro_pass"
"azappid"
"azpass"
"azure_subscription_id"
"azure_tenant"
"bastion_password"
"bastion_ssh_command"
"common_password"
"generated_password"
"guid"
"openenv_admin_upn"
"ssh_password"
"ssh_username"
"targethost"
)

for orig_value in "${arr[@]}"
do
  echo $orig_value
  find . -name "*.adoc" -print0 |  xargs -0 perl -pi -e "s/%${orig_value}%/{${orig_value}}/g"
  grep -ri $orig_value
done