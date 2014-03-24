node[:deploy].each do |app_name, deploy|
  template "#{deploy[:deploy_to]}/current/config/aws.js" do
      source "aws.js.erb"
      mode 0660
      group deploy[:group]
      owner "deploy"

      variables(
        :access =>     (node[:aws][:access] rescue nil),
        :secret =>     (node[:aws][:access] rescue nil)
      )

     only_if do
       File.directory?("#{deploy[:deploy_to]}/current/config")
     end
  end
end