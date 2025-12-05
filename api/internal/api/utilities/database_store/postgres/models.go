package pgstore

import database "github.com/hyoaru/last-dime/api/internal/database"

type connector struct {
	host     string
	port     uint16
	user     string
	password string
	database string
}

type Store struct {
	Queries *database.Queries
}
