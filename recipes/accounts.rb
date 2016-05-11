# GitHub usernames of each op which will be used to create their account
# Also used to pull their public keys from github.com/#{op}.keys for SSH

package 'curl'

operators = %w(
  temporarilyoffline
)

group 'ops'

operators.each do |op|
  user op do
    home "/home/#{op}"
    shell '/bin/bash'
    gid 'ops'
    supports manage_home: true
  end

  directory "/home/#{op}/.ssh" do
    owner op
    group 'ops'
  end

  template "/home/#{op}/.ssh/authorized_keys" do
    source 'authorized_keys.erb'
    owner op
    group 'ops'
    mode '0600'
    variables(
      github_logins: [op]
    )
  end

  sudo op do
    group 'ops'
    nopasswd true
  end
end
