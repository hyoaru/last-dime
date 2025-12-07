package service

import (
	"context"

	model "github.com/hyoaru/last-dime/api/internal/api/models"
	repository "github.com/hyoaru/last-dime/api/internal/api/repositories/user"
)

func NewUserService() *UserService {
	return &UserService{Repository: repository.NewPgstoreRepository()}
}

func (r *UserService) CreateUser(ctx context.Context, params CreateUserParams) (model.User, error) {
	return r.Repository.Create(ctx, repository.CreateUserParams{
		FirstName: params.FirstName,
		LastName:  params.LastName,
		Username:  params.Username,
		Email:     params.Email,
		Password:  params.Password,
	})
}
