#!/usr/bin/env lua

function waitForEnter()
  print("Press enter to continue: ")
  io.read()
end

function createSshKeypair(username)
  print("Run:")
  print(string.format("   ssh-keygen -t rsa -f ~/%s", username))
  waitForEnter()
end

function gitCommit(username)
  print("Copy ~/new_key.pub into the `user_keys` Git repository, then run:")
  print(string.format("    git commit %s", username))
  print("    git push")
  waitForEnter()
end

function waitForBuild()
  build_url = "http://example.com/builds/user_keys"
  print(string.format("Wait for the build job at %s to finish", build_url))
  waitForEnter()
end

function retrieveUserEmail(username)
  dir_url = "http://example.com/directory"
  print(string.format("Go to %s", dir_url))
  print(string.format("Find the email address for user `%s`", username))
  print("Paste the email address and press enter: ")
  local email = io.read()
  print()
  return email
end

function sendPrivateKey(email)
  print("Go to 1Password")
  print("Paste the contents of ~/new_key into a new document")
  print(string.format("Share the document with %s", email))
  waitForEnter()
end

username = arg[1]
createSshKeypair(username)
gitCommit(username)
waitForBuild()
email = retrieveUserEmail(username)
sendPrivateKey(email)
print("Done.")
