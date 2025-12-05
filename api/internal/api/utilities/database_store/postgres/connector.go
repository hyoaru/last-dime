package pgstore

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

func (c *connector) GetConnectionString() string {
	return fmt.Sprintf(
		"postgres://%s:%s@%s:%d/%s?sslmode=disable",
		c.user, c.password, c.host, c.port, c.database,
	)
}

func (c *connector) Connect() (*sql.DB, error) {
	dsn := c.GetConnectionString()
	return sql.Open("postgres", dsn)
}
