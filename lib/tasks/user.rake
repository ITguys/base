require 'optparse'
require 'rake'

namespace :user do |args|
  desc '手动添加用户'
  task :add => :environment do
    options = {}
    op = OptionParser.new(args) do |opts|
      opts.banner = 'Usage: rake user:add -- [options]'
      opts.on("-n", "--name ARG", '用户姓名') do |name|
        options[:name] = name
      end
      opts.on("-e", "--email ARG", '用户登录邮箱') do |email|
        options[:email] = email
      end
    end
    op.parse!
    user = User.new
    user.attributes = options
    user.save(validate: false)
    user.update_attribute(:reset_password_token, SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz'))
    BaseMailer.user_sets_password(user).deliver
    puts '用户确认邮件已经发送至您的邮箱，请确认并设置密码!'
  end
end
