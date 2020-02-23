import TownsRepository from "../repositories/townsRepository.js";
import UsersRepository from "../repositories/usersRepository.js";
import SessionsRepository from "../repositories/sessionsRepository.js";

const repositories = {
  towns: TownsRepository,
  users: UsersRepository,
  sessions: SessionsRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};
