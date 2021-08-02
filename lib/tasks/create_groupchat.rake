require 'qywechat/notifier'

task create_groupchat: :environment do
  # raise '请先填写群 ID' 
  if Qywechat::Notifier::QyAPI.chatid.present? 
    puts "群 ID: #{Qywechat::Notifier::QyAPI.chatid}"
  else
    puts  "如果不填，系统会随机生成群id"
  end
  puts('请输入群聊名:')
  name = STDIN.gets().gsub(/\r\n|\n/, '')
  raise '群聊名不能为空' unless name.present?
  puts('请输入群主名(企业内唯一ID):')
  owner = STDIN.gets().gsub(/\r\n|\n/, '')
  raise '群主名不能为空' unless owner.present?
  puts('请输入一个群员名(企业内唯一ID,额外的群员可在新创建的群内直接添加):')
  username = STDIN.gets().gsub(/\r\n|\n/, '')
  raise '群员名不能为空' unless username.present?
  userlist = [owner, username]

  client = Qywechat::Notifier::QyAPI::Client.new
  res = client.post('/cgi-bin/appchat/create', params: { access_token: Qywechat::Notifier::QyAPI.api_token.get_access_token }, json: {
    chatid: Qywechat::Notifier::QyAPI.chatid,
    name: name,
    owner: owner,
    userlist: userlist
  })
  puts res
  if Qywechat::Notifier::QyAPI.chatid.blank?
    Qywechat::Notifier::QyAPI.chatid = res["chatid"]
  end
  Qywechat::Notifier::QyAPI.api_message.send_groupchat("create groupchat #{name} ok")
end

task :send_groupchat, [:content] => :environment do
  puts content = ENV['content'] || 'test send_message'
  Qywechat::Notifier::QyAPI.api_message.send_groupchat(content)
end
