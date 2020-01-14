import TownsRepository from "../repositories/townsRepository.js";

const repositories = {
  towns: TownsRepository
};

export const RepositoryFactory = {
  get: name => repositories[name]
};
