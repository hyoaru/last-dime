package repository

import (
	"context"

	model "github.com/hyoaru/last-dime/api/internal/api/models"
)

type UserRepository interface {
	Create(ctx context.Context, params CreateUserParams) (model.User, error)
}
