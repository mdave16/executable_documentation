#!/usr/bin/env node
const readlineSync = require("readline-sync")

const waitForEnter = () => {
	readlineSync.question("Press Enter to continue: ")
}
const createSshKeypair = username => {
	console.log("Run:")
	console.log(`   ssh-keygen -t rsa -f ~/${username}`)
	waitForEnter()
}
const gitCommit = username => {
	console.log(
		"Copy ~/new_key.pub into the `user_keys` Git repository, then run:"
	)
	console.log(`    git commit ${username}`)
	console.log("    git push")
	waitForEnter()
}
const waitForBuild = () => {
	build_url = "http://example.com/builds/user_keys"
	console.log(`Wait for the build job at ${build_url} to finish`)
	waitForEnter()
}
const retrieveUserEmail = username => {
	dir_url = "http://example.com/directory"
	console.log(`Go to ${dir_url}`)
	console.log(`Find the email address for user '${username}'`)
	return readlineSync.question("Paste the email address and press enter: ")
}
const sendPrivateKey = email => {
	console.log("Go to 1Password")
	console.log("Paste the contents of ~/new_key into a new document")
	console.log(`Share the document with ${email}`)
	waitForEnter()
}
username = process.argv[2]
createSshKeypair(username)
gitCommit(username)
waitForBuild()
email = retrieveUserEmail(username)
sendPrivateKey(email)
console.log("Done.")
