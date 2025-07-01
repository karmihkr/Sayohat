import unittest
from settings_manager import settings_manager


class TestDatabaseDockerHostObtaining(unittest.TestCase):
    def test_obtain(self):
        self.assertEqual(settings_manager.database.docker_host, "mongo")


if __name__ == "__main__":
    unittest.main()
