import unittest

from src.repositories.users_repository import users_repository


class TestGetMatchingUser(unittest.TestCase):
    def setUp(self):
        for phone, name, surname, birth in [
            "+79877211857 Kate Fox 02/12/2001".split(),
            "+79877213857 Samara Slash 04/12/2014".split(),
            "+79844211857 James Jinko 25/06/1999".split(),
            "+59877211857 Emily Ameta 14/06/1999".split(),
        ]:
            users_repository.insert(phone=phone, name=name, surname=surname, birth=birth)

    def test_birth(self):
        self.assertEqual(users_repository.get_matching_user(birth="25/06/1999")["birth"], "25/06/1999")

    def test_name(self):
        self.assertEqual(users_repository.get_matching_user(name="Emily")["name"], "Emily")

    def test_surname(self):
        self.assertEqual(users_repository.get_matching_user(surname="Slash")["surname"], "Slash")

if __name__ == "__main__":
    unittest.main()
