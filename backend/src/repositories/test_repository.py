import pymongo


class BasicMongoFunctional:
    def __init__(self, host="mongo"):
        self.connection = pymongo.MongoClient(host, 27017)
        self.database = self.connection.database

    def insert_test_message(self):
        self.database.user.insert_one({"first_name": "Mongo", "last_name": "No one likes SQL"})

    def get_test_message(self):
        return {"test_message": self.database.user.find_one()["last_name"]}


mongodb = BasicMongoFunctional()
