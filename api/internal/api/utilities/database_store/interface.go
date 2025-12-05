package dtbstore

import "database/sql"

type DatabaseConnector interface {
	GetConnectionString() string
	Connect() (*sql.DB, error)
}
