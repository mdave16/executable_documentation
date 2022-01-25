#!/usr/bin/env php
<?php
function wait_for_enter(){
  readline();
}

function create_ssh_keypair($username){
  echo "Run:\n";
  printf("\tssh-keygen -t rsa -f ~/%s\n", $username);
  wait_for_enter();
}

function git_commit($username){
  echo "Copy ~/new_key.pub into the `user_keys` Git repository, then run:\n";
  printf("\tgit commit %s\n", $username);
  echo "\tgit push\n";
  wait_for_enter();
}

function wait_for_build(){
  $buildUrl = "http://example.com/builds/user_keys";
  printf("Wait for the build job at %s to finish\n", $buildUrl);
  wait_for_enter();
}

function retrieve_user_email($username){
  $dirUrl = "http://example.com/directory";
  printf("Go to %s\n", $dirUrl);
  printf("Find the email address for user `%s`\n", $username);
  return readline("Paste the email address and press enter: \n");
}

function send_private_key($email){
  echo "Go to 1Password\n";
  echo "Paste the contents of ~/new_key into a new document\n";
  printf("Share the document with %s\n", $email);
  wait_for_enter();
}

$username = $argv[1];
create_ssh_keypair($username);
git_commit($username);
wait_for_build();
$email = retrieve_user_email($username);
send_private_key($email);
echo "Done.\n";

