package main

import (
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
)

func isUp(ip string) (err error) {
	err = nil

	url := "http://" + ip + ":9000/up"
	resp, err := http.Get(url)

	if err != nil {
		return
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		return
	}

	log.Printf("- %s: %s", ip, string(body))
	return
}

func main() {
	workers := strings.Split(os.Getenv("WORKERS"), "/")

	allUp := false

	log.Println("Waiting for workers...")

	for !allUp {
		allUp = true
		for _, w := range workers {
			err := isUp(w)
			if err != nil {
				allUp = false
			}
		}
	}
}
