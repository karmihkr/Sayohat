import httpx


class RideCreatedSuccessfully(httpx.Response):
    def __init__(self):
        json = {
            "Message": "New ride was added to the database!"
        }
        super().__init__(200, json=json)


class RideQueriedSuccessfully(httpx.Response):
    def __init__(self, json):
        json["Message"] = "Ride was queried successfully!"
        super().__init__(200, json=json)
