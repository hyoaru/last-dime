package utility

import (
	"log"
	"os"
	"strconv"

	dtbstore "github.com/hyoaru/last-dime/api/internal/api/utilities/database_store"
	database "github.com/hyoaru/last-dime/api/internal/database"
)

func New() *PgDtbStore {
	port, err := strconv.Atoi(os.Getenv("DATABASE_PORT"))
	if err != nil {
		log.Fatal("Port is not a valid integer", err)
	}

	var c dtbstore.DatabaseConnector = &postgresDatabaseConnector{
		host:     os.Getenv("DATABASE_HOST"),
		port:     uint16(port),
		user:     os.Getenv("DATABASE_USER"),
		password: os.Getenv("DATABASE_PASSWORD"),
	}

	db, err := c.Connect()
	if err != nil {
		log.Fatal("Error connecting to database", err)
	}

	return &PgDtbStore{Queries: database.New(db)}
}
