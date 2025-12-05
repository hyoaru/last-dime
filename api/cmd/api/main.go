package main

import (
	"log"
	"os"

	"github.com/joho/godotenv"

	app "github.com/hyoaru/last-dime/api/internal"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	app := &app.Application{
		Config: app.Config{
			Addr: ":" + os.Getenv("PORT"),
		},
	}

	mux := app.Mount()
	log.Fatal(app.Run(mux))
}
