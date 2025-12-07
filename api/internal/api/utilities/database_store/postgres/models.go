package utility

import database "github.com/hyoaru/last-dime/api/internal/database"

type postgresDatabaseConnector struct {
	host     string
	port     uint16
	user     string
	password string
	database string
}

type PgDtbStore struct {
	Queries *database.Queries
}
