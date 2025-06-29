import unittest

from src.repositories.users_repository import users_repository


class TestInsertUser(unittest.TestCase):
    def setUp(self):
        users_repository.insert(phone="+79877211857", name="Kate", surname="Fox", birth="02/12/2001")

    def test_insert_second(self):
        users_repository.insert(phone="+79877213857", name="Samara", surname="Slash", birth="04/12/2014")
        self.assertEqual(len(list(users_repository.database.user.find())), 2)

    def test_insert_third(self):
        users_repository.insert(phone="+79845211857", name="James", surname="Jinko", birth="25/06/1999")
        self.assertEqual(len(list(users_repository.database.user.find())), 4)


if __name__ == "__main__":
    unittest.main()
