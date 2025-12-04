package main

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	app := &application{
		config: config{
			addr: ":" + os.Getenv("PORT"),
		},
	}

	mux := app.mount()
	log.Fatal(app.run(mux))
}
