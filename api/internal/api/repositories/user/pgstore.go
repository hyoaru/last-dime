package repository

import (
	"context"

	model "github.com/hyoaru/last-dime/api/internal/api/models"
	pgstore "github.com/hyoaru/last-dime/api/internal/api/utilities/database_store/postgres"
	database "github.com/hyoaru/last-dime/api/internal/database"
)

type UserPgstoreRepository struct {
	Store *pgstore.PgDtbStore
}

func NewPgstoreRepository() *UserPgstoreRepository {
	return &UserPgstoreRepository{Store: pgstore.New()}
}

func (r *UserPgstoreRepository) Create(ctx context.Context, params CreateUserParams) (model.User, error) {
	u, err := r.Store.Queries.CreateUser(
		ctx,
		database.CreateUserParams{
			FirstName: params.FirstName,
			LastName:  params.LastName,
			Username:  params.Username,
			Email:     params.Email,
			Password:  params.Password,
		})

	return model.User(u), err
}
