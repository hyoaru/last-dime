package service

import repository "github.com/hyoaru/last-dime/api/internal/api/repositories/user"

type UserService struct {
	Repository *repository.UserPgstoreRepository
}

type CreateUserParams struct {
	FirstName string
	LastName  string
	Username  string
	Email     string
	Password  string
}
