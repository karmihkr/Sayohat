import unittest
from settings_manager import settings_manager


class TestDatabasePortObtaining(unittest.TestCase):
    def test_obtain(self):
        self.assertEqual(settings_manager.database.port, 27017)


if __name__ == "__main__":
    unittest.main()
