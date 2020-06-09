package main

import (
	"context"
	"log"
	"net/http"
)

func main() {
	log.Printf("Waiting for shutdown signal...")
	m := http.NewServeMux()
	s := http.Server{Addr: ":9000", Handler: m}
	m.HandleFunc("/shutdown", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Signal receieved, shutting down...")
		w.Write([]byte("OK\n"))
		go func() {
			if err := s.Shutdown(context.Background()); err != nil {
				log.Fatal(err)
			}
		}()
	})
	m.HandleFunc("/up", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("OK\n"))
	})
	if err := s.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatal(err)
	}
	log.Printf("Done")
}
