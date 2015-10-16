if my_etcd_elb = node[:opsworks][:stack]['elb-load-balancers'].select{|elb| elb[:layer_id] == node[:opsworks][:layers]['etcd'][:id] }.first

    template "/etc/init.d/kubernetes-master" do
      mode "0755"
      owner "root"
      source "kubernetes-master.erb"
      variables({
		:etcd_url => my_etcd_elb[:dns_name],
		:cluster_cidr => node['kubernetes']['cluster_cidr'],
		:ba_path => "/root/ba_file",
		:etcd_ba_account => "root",
		:etcd_ba_password => node['etcd_password']
      })
    end
end

file "/root/ba_file" do
	owner 'root'
	group 'root'
	mode '0600'
	content "#{node['ba']['password']},#{node['ba']['account']},#{node['ba']['uid']}"
	action :create
end


