node[:deploy].each do |app_name, deploy|

  script "generate_docs" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    grunt apidoc
    EOH
  end

end