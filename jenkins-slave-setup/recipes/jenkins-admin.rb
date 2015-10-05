#add jenkins public key in user "jenkins"'s authorized file
file '/home/jenkins/.ssh/authorized_keys' do
    owner 'jenkins'
    group 'jenkins'
    mode '0600'
    content "#{node[:jenkins_pubkey]}\n"
    action :create
end

#grant user permission to jenkins
bash 'add-public-key' do
    user 'root'
    code <<-EOH
    cat /home/ec2-user/.ssh/authorized_keys >> /home/jenkins/.ssh/authorized_keys
    echo "jenkins  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoer
    EOH
end

#create dir
directory '/media/ephemeral0/jenkins' do
    owner 'jenkins'
    group 'jenkins'
    mode '0755'
    action :create
    recursive true
end

Chef::Log.info("***************** Jenkins slave configure finished **************")
