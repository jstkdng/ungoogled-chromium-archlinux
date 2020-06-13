package main

import (
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
)

func terminate(ip string) (err error) {
	err = nil

	url := "http://" + ip + ":9000/shutdown"
	resp, err := http.Get(url)

	if err != nil {
		return
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)

	if err != nil {
		return
	}

	log.Printf("Terminating %s: %s", ip, string(body))
	return
}

func main() {
	workers := strings.Split(os.Getenv("WORKERS"), "/")

	for _, w := range workers {
		terminate(w)
	}
}
