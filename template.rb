#!/usr/bin/env ruby

def wait_for_enter
  gets.chomp
end

def create_ssh_keypair(username)
  puts 'Run:'
  puts "   ssh-keygen -t rsa -f ~/#{username}"
  wait_for_enter
end

def git_commit(username)
  puts 'Copy ~/new_key.pub into the `user_keys` Git repository, then run:'
  puts "    git commit #{username}"
  puts '    git push'
  wait_for_enter
end

def wait_for_build
  build_url = 'http://example.com/builds/user_keys'
  puts "Wait for the build job at #{build_url} to finish"
  wait_for_enter
end

def retrieve_user_email(username)
  dir_url = 'http://example.com/directory'
  puts "Go to #{dir_url}"
  puts "Find the email address for user `#{username}`"
  puts 'Paste the email address and press enter: '
  gets.chomp
end

def send_private_key(email)
  puts 'Go to 1Password'
  puts 'Paste the contents of ~/new_key into a new document'
  puts "Share the document with #{email}"
  wait_for_enter
end

username = ARGV[0]
create_ssh_keypair(username)
git_commit(username)
wait_for_build
email = retrieve_user_email(username)
send_private_key(email)
puts 'Done.'
