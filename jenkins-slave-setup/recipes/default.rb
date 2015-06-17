user 'jenkins' do
	home '/home/jenkins'
	shell '/bin/bash'
	password '$1$1BYPpnSk$UiWmVO9/J3lKf290/Oec4.'
	action :create
end

directory '/home/jenkins' do
    owner 'jenkins'
    group 'jenkins'
end

bash 'install-ant' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install ant
	EOH
end

Chef::Log.info("***************** Jenkins slave setup finished **************")
