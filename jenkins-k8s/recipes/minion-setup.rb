if my_master_elb = node[:opsworks][:stack]['elb-load-balancers'].select{|elb| elb[:layer_id] == node[:opsworks][:layers]['kub-master'][:id] }.first

    template "/etc/init.d/kubernetes-minion" do
      mode "0755"
      owner "root"
      source "kubernetes-minion.erb"
      variables :master_url => my_master_elb[:dns_name]
      notifies :disable, 'service[kubernetes-minion]', :delayed
    end
end

service "kubernetes-minion" do
	action :nothing
end
