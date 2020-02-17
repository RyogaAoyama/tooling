import TownsRepository from "../repositories/townsRepository.js";
import UsersRepository from "../repositories/usersRepository.js";

const repositories = {
  towns: TownsRepository,
  users: UsersRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};
