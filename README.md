# WeatherApp 🌦️

A Flask-based web application to fetch, display, and manage weather data for cities worldwide using the OpenWeatherMap API. WeatherApp features local caching with SQLite, a user-friendly interface, and automated deployment via Docker, Jenkins, Ansible, and Terraform.

<img width="786" height="586" alt="Untitled Diagram drawio (1)" src="https://github.com/user-attachments/assets/f7c3df82-23dc-4148-ac4b-8be3f1b4390d" />

---

## 🚀 Features

- **Real-Time Weather**: Search any city and get up-to-date weather info.
- **Search History**: View and manage previously searched cities.
- **Last Search Memory**: Automatically remembers your last searched city.
- **Delete History**: Remove cities from your search history.
- **Dockerized**: Easy containerized deployment.
- **CI/CD Pipeline**: Automated build, push, and deployment using Jenkins and Ansible.
- **Infrastructure as Code**: Provision AWS resources with Terraform.
- **Environment Variables**: Secure API key management via environment variables.

---

## 🛠️ Prerequisites

- Python 3.x
- Docker & Docker Hub account
- Jenkins (for CI/CD)
- Ansible (for deployment)
- Terraform (for AWS provisioning)
- OpenWeatherMap API Key ([Get yours here](https://openweathermap.org/api))
- AWS Account (for EC2 provisioning)
- S3 Bucket for Terraform state (see `terraform/backend.tf`)

---

## ⚡ Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-repository/weatherapp.git
cd weatherapp
```

### 2. Set Up Credentials

- **Jenkins**:
  - Add your SSH key as **"aws-ssh-key"** (type: SSH Username with Private Key).
  - Add your Docker Hub token as **"dockerhub-credentials"** (type: Username with Password).
  - Add your AWS IAM user as **"aws-credentials"** (type: Username with Password).
  - Add your OpenWeatherMap API key as secret text called **open_weather_api_key**.

### 3. Configure AWS & Terraform

- Update the AMI ID in `terraform/ec2.tf` if needed for your region.
- Ensure your S3 bucket exists and matches the name in `terraform/backend.tf`.
- Set your AWS region in `terraform/providers.tf`.

---

## 🖥️ Usage

1. **Search for a City**:  
   Enter a city name (e.g., "London") to view its temperature, weather description, and icon.

2. **View Search History**:  
   Previously searched cities are listed below the search bar.

3. **Delete a City**:  
   Click "Delete" next to any city to remove it from history.

---

## 🏗️ Deployment

### CI/CD Pipeline (Jenkins)

- **Stages**:
  1. Build Docker image.
  2. Push image to Docker Hub.
  3. Provision AWS infrastructure with Terraform.
  4. Deploy app using Ansible.

### Ansible Playbook

- Installs and starts Docker.
- Logs into Docker Hub.
- Pulls the Docker image.
- Runs the container on port 5000 with your API key.

> **Note:** The playbook is compatible with AWS Linux. For other distributions, add the Docker repository as described [Install Docker Engine.](https://docs.docker.com/engine/install/).

---

## 🗂️ Project Structure

```text
weather-app/
├── app/                # Flask application code
├── ansible/            # Ansible playbook & inventory
├── docker/             # Dockerfile
├── jenkins/            # Jenkins pipeline
├── terraform/          # Terraform configs for AWS
├── requirements.txt    # Python dependencies
└── README.md           # This file
```

---

## 📸 Screenshots

![Jenkins Pipeline](https://github.com/user-attachments/assets/962bf001-b694-474f-b5ad-ed586f13f251)
![app](https://github.com/user-attachments/assets/59b122d7-3721-4a8b-8c97-fb30899272b0)
![app](https://github.com/user-attachments/assets/cb3fd80a-837c-4f71-b51b-fea153837091)
