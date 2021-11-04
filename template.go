package main

import (
	"fmt"
	"os"
)

func waitForEnter() {
	var tmp string
	fmt.Println("Press anything to continue: ")
	fmt.Scan(&tmp)
}
func createSshKeypair(username string) {
	fmt.Println("Run:")
	fmt.Printf("   ssh-keygen -t rsa -f ~/%v", username)
	fmt.Println()
	waitForEnter()
}
func gitCommit(username string) {
	fmt.Println("Copy ~/new_key.pub into the `user_keys` Git repository, then run:")
	fmt.Printf("    git commit %v", username)
	fmt.Println()
	fmt.Println("    git push")
	waitForEnter()
}
func waitForBuild() {
	build_url := "http://example.com/builds/user_keys"
	fmt.Printf("Wait for the build job at %v to finish", build_url)
	fmt.Println()
	waitForEnter()
}
func retrieveUserEmail(username string) string {
	dir_url := "http://example.com/directory"
	fmt.Printf("Go to %v", dir_url)
	fmt.Println()
	fmt.Printf("Find the email address for user `%v`", username)
	fmt.Println()
	var email string
	fmt.Println("Paste the email address and press enter: ")
	fmt.Scan(&email)
	return email
}
func sendPrivateKey(email string) {
	fmt.Println("Go to 1Password")
	fmt.Println("Paste the contents of ~/new_key into a new document")
	fmt.Printf("Share the document with %v", email)
	fmt.Println()
	waitForEnter()
}

func main() {
	username := os.Args[1]
	createSshKeypair(username)
	gitCommit(username)
	waitForBuild()
	email := retrieveUserEmail(username)
	sendPrivateKey(email)
	fmt.Println("Done.")
}
