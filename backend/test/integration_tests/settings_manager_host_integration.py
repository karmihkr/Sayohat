import unittest
from settings_manager import settings_manager


class TestHostObtaining(unittest.TestCase):
    def test_obtain(self):
        self.assertEqual(settings_manager.api.host, "http://127.0.0.1")


if __name__ == "__main__":
    unittest.main()
