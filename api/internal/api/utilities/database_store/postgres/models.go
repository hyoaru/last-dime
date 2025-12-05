package pgstore

import database "github.com/hyoaru/last-dime/api/internal/database"

type postgresConnector struct {
	host     string
	port     uint16
	user     string
	password string
	database string
}

type PostgresStore struct {
	Queries *database.Queries
}
