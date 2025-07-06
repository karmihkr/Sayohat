import pymongo

from settings_manager import settings_manager


class UsersRepository:
    def __init__(self, host, port):
        self.connection = pymongo.MongoClient(host, port)
        self.database = self.connection.database

    def get_matching_user(self, **fields):
        return self.database.user.find_one(filter=fields)

    def insert(self, **fields):
        self.database.user.insert_one(fields)

    def update(self, user, data):
        self.database.user.update_one({"_id": user["_id"]}, {"$set": data})


users_repository = UsersRepository(settings_manager.database.host, settings_manager.database.port)
