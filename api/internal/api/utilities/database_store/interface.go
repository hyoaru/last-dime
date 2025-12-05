package dtbstore

import "database/sql"

type Connector interface {
	GetConnectionString() string
	Connect() (*sql.DB, error)
}
