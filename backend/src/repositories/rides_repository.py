import pymongo

from settings_manager import settings_manager


class RidesRepository:
    def __init__(self, host, port):
        self.connection = pymongo.MongoClient(host, port)
        self.database = self.connection.database

    def insert(self, **fields):
        self.database.ride.insert_one(fields)

    def get_matching_ride(self, **filters):
        return self.database.ride.find_one(filter=filters)

    def get_matching_rides(self, **filters):
        return self.database.ride.find(filter=filters)


rides_repository = RidesRepository(settings_manager.database.host, settings_manager.database.port)
