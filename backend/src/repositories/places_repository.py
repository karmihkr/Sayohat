import pymongo

from settings_manager import settings_manager


class PlacesRepository:
    def __init__(self, host, port):
        self.connection = pymongo.MongoClient(host, port)
        self.database = self.connection.database

    def insert(self, **fields):
        self.database.place.insert_one(fields)

    def get_matching_place(self, **filters):
        return self.database.place.find_one(filter=filters)


places_repository = PlacesRepository(settings_manager.database.host, settings_manager.database.port)
