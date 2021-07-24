## Black Thursday
### A hand-rolled Ruby simulation of a sales platform database, including business intelligence and CRUD functionality. 
#### 4-person group project completed over 10 days. 
#### OUR DEVS: [Noah Zinter](https://www.linkedin.com/in/noahzinter), [Richard DeSilvey](https://www.linkedin.com/in/richard-desilvey-33161696/), [Molly Krumholz](https://www.linkedin.com/in/mkrumholz/), [Samantha Peterson](https://www.linkedin.com/in/samantha-peterson-15b18220b/)

---

Black Thursday Schema: ![Black Thursday Schema](https://user-images.githubusercontent.com/77814101/126880269-52bd1ed9-6eee-481e-8082-e4d0b955f878.png)

---

The project has no dependencies, and can be cloned and run as-is. There is no front-end for this project, so the best way to get a sense of what it is doing is to explore the specs and run rspec to verify the functionality. The flow of the project is as follows:

Data is loaded from six CSV files in the '/data' directory. The `FileIo` class instantiates objects corresponding to that data into six models, `Merchant`, `Item`, `InvoiceItem`, `Invoice`, `Transaction`, and `Customer` (see db diagram). To handle aggregation of these models, each model has a corresponding `Repository` class. These models and respositories are loaded into a `SalesEngine` class, which is essentially a handmade replication of a SQL database. The `SalesAnalyst` class performs calculations based on the relationships between these data, acting very much like a hand-rolled Object-Relational Mapper. 


