node[:deploy].each do |app_name, deploy|
  if File.directory?("#{deploy[:deploy_to]}/current/docs-template") && !File.directory?("#{deploy[:deploy_to]}/current/public/docs")

    Chef::Log.debug("Generating apidocs for #{app_name}")

    script "install_bower" do
      interpreter "bash"
      user "root"
      cwd "#{deploy[:deploy_to]}/current"
      code <<-EOH
      npm install -g bower
      EOH
    end

    execute "bower install" do
      cwd "#{deploy[:deploy_to]}/current/docs-template"
      user "deploy"
      environment ({'HOME' => '/home/deploy'})
    end

    script "generate_docs" do
      interpreter "bash"
      user "root"
      cwd "#{deploy[:deploy_to]}/current"
      code <<-EOH
      npm install -g grunt-cli
      grunt apidoc
      EOH
    end
  else
    Chef::Log.debug("App has not apidocs configured or already generated")
  end
end