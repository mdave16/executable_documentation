import sys
 
def wait_for_enter():
    input("Press Enter to continue: ")
 
def create_ssh_keypair(username):
    print("Run:")
    print("   ssh-keygen -t rsa -f ~/{0}".format(username))
    wait_for_enter()
 
def git_commit(username):
    print("Copy ~/new_key.pub into the `user_keys` Git repository, then run:")
    print("    git commit {0}".format(username))
    print("    git push")
    wait_for_enter()
 
def wait_for_build():
    build_url = "http://example.com/builds/user_keys"
    print("Wait for the build job at {0} to finish".format(build_url))
    wait_for_enter()
 
def retrieve_user_email(username):
    dir_url = "http://example.com/directory"
    print("Go to {0}".format(dir_url))
    print("Find the email address for user `{0}`".format(username))
    return input("Paste the email address and press enter: ")
 
def send_private_key(email):
    print("Go to 1Password")
    print("Paste the contents of ~/new_key into a new document")
    print("Share the document with {0}".format(email))
    wait_for_enter()
 
if __name__ == "__main__":
    username = sys.argv[1]
    create_ssh_keypair(username)
    git_commit(username)
    wait_for_build()
    email = retrieve_user_email(username)
    send_private_key(email)
    print("Done.")