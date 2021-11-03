import sys
 
def wait_for_enter():
    raw_input("Press Enter to continue: ")
 
class CreateSSHKeypairStep(object):
    def run(self, context):
        print("Run:")
        print("   ssh-keygen -t rsa -f ~/{0}".format(context["username"]))
        wait_for_enter()
 
class GitCommitStep(object):
    def run(self, context):
        print("Copy ~/new_key.pub into the `user_keys` Git repository, then run:")
        print("    git commit {0}".format(context["username"]))
        print("    git push")
        wait_for_enter()
 
class WaitForBuildStep(object):
    build_url = "http://example.com/builds/user_keys"
    def run(self, context):
        print("Wait for the build job at {0} to finish".format(self.build_url))
        wait_for_enter()
 
class RetrieveUserEmailStep(object):
    dir_url = "http://example.com/directory"
    def run(self, context):
        print("Go to {0}".format(self.dir_url))
        print("Find the email address for user `{0}`".format(context["username"]))
        context["email"] = raw_input("Paste the email address and press enter: ")
 
class SendPrivateKeyStep(object):
    def run(self, context):
        print("Go to 1Password")
        print("Paste the contents of ~/new_key into a new document")
        print("Share the document with {0}".format(context["email"]))
        wait_for_enter()
 
if __name__ == "__main__":
    context = {"username": sys.argv[1]}
    procedure = [
        CreateSSHKeypairStep(),
        GitCommitStep(),
        WaitForBuildStep(),
        RetrieveUserEmailStep(),
        SendPrivateKeyStep(),
    ]
    for step in procedure:
        step.run(context)
    print("Done.")