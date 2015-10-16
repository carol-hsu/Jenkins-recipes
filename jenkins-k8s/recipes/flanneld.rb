bash 'install_flannel' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget --max-redirect 255 https://github.com/coreos/flannel/releases/download/v0.5.2/flannel-0.5.2-linux-amd64.tar.gz
  tar zxvf flannel-0.5.2-linux-amd64.tar.gz
  cd flannel-0.5.2
  cp flanneld /usr/local/bin
  EOH
end


if my_etcd_elb = node[:opsworks][:stack]['elb-load-balancers'].select{|elb| elb[:layer_id] == node[:opsworks][:layers]['etcd'][:id] }.first

    template "/etc/init.d/flanneld" do
      mode "0755"
      owner "root"
      source "flanneld.erb"
      variables ({
		:elb_url => my_etcd_elb[:dns_name],
		:etcd_password => node[:etcd_password]
	  })
      notifies :disable, 'service[flanneld]', :delayed
    end
end


service "flanneld" do
	action :nothing
end
