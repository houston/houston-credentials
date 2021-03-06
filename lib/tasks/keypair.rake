require "shellwords"

namespace :keypair do
  task :generate do |t|
    if File.exists?(Houston.config.keypair)
      puts "#{Houston.config.keypair} exists"
      exit
    end

    tmp = Houston.root.to_s

    `openssl genrsa -des3 -passout pass:#{Shellwords.escape Houston::Credentials.config.passphrase} -out #{tmp}/config/private.pem 2048`
    `openssl rsa -in #{tmp}/config/private.pem -passin pass:#{Shellwords.escape Houston::Credentials.config.passphrase} -out #{tmp}/config/public.pem -outform PEM -pubout`
    `cat #{tmp}/config/private.pem #{tmp}/config/public.pem >> #{Houston.config.keypair}`
    `rm #{tmp}/config/private.pem #{tmp}/config/public.pem`
  end
end
