from locust import HttpUser, task


json_data = {
   "CHAS":{
      "0":0
   },
   "RM":{
      "0":6.575
   },
   "TAX":{
      "0":296.0
   },
   "PTRATIO":{
      "0":15.3
   },
   "B":{
      "0":396.9
   },
   "LSTAT":{
      "0":4.98
   }
}


class HelloWorldUser(HttpUser):
    @task
    def predict(self):
        self.client.post(
            url="/predict",
            json=json_data
        )
