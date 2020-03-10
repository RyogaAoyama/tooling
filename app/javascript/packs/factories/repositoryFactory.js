import TownsRepository from "../repositories/townsRepository.js";
import UsersRepository from "../repositories/usersRepository.js";
import SessionsRepository from "../repositories/sessionsRepository.js";
import DestinationRepository from "../repositories/destinationRepository.js"

const repositories = {
  towns: TownsRepository,
  users: UsersRepository,
  sessions: SessionsRepository,
  destinations: DestinationRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};
