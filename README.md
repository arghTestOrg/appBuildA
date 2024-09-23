
# Spring Boot CRUD Application

## Overview

This is a simple **Customer Management** application built using **Spring Boot**. It demonstrates basic **CRUD** (Create, Read, Update, Delete) functionality for managing customers. The backend is powered by **Spring Boot**, and the application connects to a **MongoDB** database deployed on an EC2 instance. The frontend uses **Bootstrap** for basic styling and provides buttons for creating, updating, and deleting customers.

## Features
- **Add Customers**: Create a new customer with a name and email.
- **Update Customers**: Modify the details of an existing customer.
- **Delete Customers**: Remove a customer from the database.
- **List Customers**: View all the customers in a nicely styled table.

## Technologies Used
- **Java**: OpenJDK 21
- **Spring Boot**: 3.3.x
- **MongoDB**: Database for storing customer information
- **Bootstrap**: Frontend styling
- **Docker**: To containerize the application
- **Kubernetes (EKS)**: To deploy the application
- **GitHub Actions**: CI/CD for building and deploying the application

## Prerequisites
- **Java 21** (OpenJDK)
- **Maven** (for building the project)
- **MongoDB**: The application connects to a MongoDB instance.
- **Docker**: To build and run the application in a container (if needed).
- **Kubernetes**: The app can be deployed to AWS EKS or any Kubernetes environment.
  
## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/<your-repository>.git
cd <your-repository>
```

### 2. Configure MongoDB Connection

The application uses MongoDB, and the connection details should be set in the `application.properties` file. Update the MongoDB URI in `src/main/resources/application.properties`:

```properties
spring.data.mongodb.uri=mongodb://${SPRING_DATA_MONGODB_USERNAME}:${SPRING_DATA_MONGODB_PASSWORD}@${MONGODB_ENDPOINT}/customers
```

Ensure the following environment variables are set:
- `SPRING_DATA_MONGODB_USERNAME`: Your MongoDB username
- `SPRING_DATA_MONGODB_PASSWORD`: Your MongoDB password
- `MONGODB_ENDPOINT`: The MongoDB endpoint (e.g., `localhost`, or the EC2 instance's address)

### 3. Build the Project

You can build the project using Maven:

```bash
mvn clean package
```

### 4. Run the Application Locally

To run the Spring Boot application locally:

```bash
mvn spring-boot:run
```

The application will be available at [http://localhost:8080](http://localhost:8080).

### 5. Dockerize the Application

To build and run the Docker container for the application:

- **Build the Docker image**:

  ```bash
  docker build -t springboot-crud-app .
  ```

- **Run the Docker container**:

  ```bash
  docker run -p 8080:8080 springboot-crud-app
  ```

### 6. Deploy to Kubernetes (EKS)

To deploy the application to a Kubernetes cluster (such as AWS EKS), follow the instructions below:

#### a. Store Credentials and EKS Cluster Name in GitHub Secrets

Before deploying to Kubernetes using GitHub Actions, ensure the following **secrets** are configured in the repository or organization under **Settings > Secrets and Variables**:
- **`AWS_ACCESS_KEY_ID`**: Your AWS access key ID.
- **`AWS_SECRET_ACCESS_KEY`**: Your AWS secret access key.
- **`AWS_REGION`**: The AWS region where your EKS cluster is deployed (e.g., `us-east-1`).
- **`AWS_BUCKET`**: The S3 bucket used for Terraform state (if applicable).
- **`SPRING_DATA_MONGODB_USERNAME`**: MongoDB username.
- **`SPRING_DATA_MONGODB_PASSWORD`**: MongoDB password.
- **`MONGODB_ENDPOINT`**: MongoDB instance endpoint (IP or DNS).
- **`EKS_CLUSTER_NAME`**: The name of your EKS cluster (required for `kubectl` configuration).

#### b. Update Kubeconfig for EKS Cluster

In the GitHub Actions workflow, use the stored `EKS_CLUSTER_NAME` secret to configure `kubectl` for your EKS cluster by running:

```bash
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME
```

This step ensures that `kubectl` is configured to manage your EKS cluster.

#### c. Apply Deployment and Service YAML Files

Once your kubeconfig is updated, deploy the application to the EKS cluster by applying the Kubernetes YAML files:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

#### d. Retrieve the LoadBalancer URL

To access the application, check the status of the service to retrieve the LoadBalancer URL:

```bash
kubectl get svc
```

Once the **EXTERNAL-IP** of the service is available, you can access the application using the LoadBalancer's public IP or DNS name.

---

## API Endpoints

- **GET /customers**: Fetch all customers
- **POST /customers**: Add a new customer (JSON payload: `{ "name": "John", "email": "john@example.com" }`)
- **PUT /customers/{id}**: Update customer by `id`
- **DELETE /customers/{id}`**: Delete customer by `id`

## Frontend Interface

The frontend UI is a simple HTML page styled with Bootstrap. You can add, update, and delete customers from the web interface.

### Add Customer:
- Fill in the "Name" and "Email" fields and click **Add Customer**.

### Update Customer:
- Click the **Update** button next to the customer’s entry. You will be prompted to update the name and email.

### Delete Customer:
- Click the **Delete** button next to the customer’s entry to remove it from the list.

## CI/CD Pipeline with GitHub Actions

This repository is set up to use **GitHub Actions** for CI/CD:
- **Build and Test**: The application is built and tested using Maven.
- **Dockerize**: A Docker image is created and pushed to the GitHub Container Registry (or your chosen registry).
- **Deploy to EKS**: The Docker image is deployed to AWS EKS.

Ensure that all required secrets (AWS credentials, MongoDB credentials, EKS cluster name, etc.) are set up in **GitHub Secrets** for the pipeline to run successfully.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---



---

