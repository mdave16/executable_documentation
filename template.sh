#!/bin/sh

wait_for_enter() {
    printf "Press Enter to continue: "
    read -r dummy
}

create_ssh_keypair() {
    username="$1"
    printf "Run:\n"
    printf " ssh-keygen -t rsa -f ~/%s\n" "$username"
    wait_for_enter
}

git_commit() {
    username="$1"
    printf "Copy ~/new_key.pub into the 'user_keys' Git repository, then run:\n"
    printf " git commit %s\n" "$username"
    printf " git push\n"
    wait_for_enter
}

wait_for_build() {
    build_url="http://example.com/builds/user_keys"
    printf "Wait for the build job at %s to finish\n" "$build_url"
    wait_for_enter
}

retrieve_user_email() {
    username="$1"
    dir_url="http://example.com/directory"
    printf "Go to %s\n" "$dir_url"
    printf "Find the email address for user '%s'\n" "$username"
    printf "Paste the email address and press enter: "
    read -r email
    printf "%s" "$email"
}

send_private_key() {
    email="$1"
    printf "Go to 1Password\n"
    printf "Paste the contents of ~/new_key into a new document\n"
    printf "Share the document with %s\n" "$email"
    wait_for_enter
}

# Check if username argument is provided
if [ $# -ne 1 ]; then
    printf "Usage: %s USERNAME\n" "$0" >&2
    exit 1
fi

username="$1"
create_ssh_keypair "$username"
git_commit "$username"
wait_for_build
email=$(retrieve_user_email "$username")
send_private_key "$email"
printf "Done.\n"
