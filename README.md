# WeatherApp - Flask-based Weather Application

A web application that retrieves and displays weather information for cities using the OpenWeatherMap API. It caches data locally in an SQLite database and provides a simple user interface to search, view, and manage weather data.
![pipeline diagram drawio (1)](https://github.com/user-attachments/assets/6b7ecfd8-645e-49ca-b46a-f1b54c88ee8c)

## Features

- **Real-time Weather Data**: Fetch current weather data for any city worldwide.
    
    
- **Last City Memory**: Remembers the last searched city for convenience.
    
- **History Management**: View and delete previously searched cities.
    
- **Dockerized**: Easily deployable using Docker containers.
    
- **CI/CD Pipeline**: Automated build, push using Jenkins and Ansible.
    

## Prerequisites

- Python
    
- Docker and Docker Hub account
    
- Jenkins (for CI/CD pipeline)
    
- Ansible (for deployment automation)

- Terraform for Iac
    
- OpenWeatherMap API Key ([Get it here](https://openweathermap.org/api))
    

## Installation

1. **Clone the Repository**:
    ```
    git clone https://github.com/your-repository/weatherapp.git
    cd weatherapp
    ```
2. **Set Up credentails Keys**:
    - In Jenkins, add your SSH key as a credential of type **"SSH Username with Private Key"**, naming it **"aws-ssh-key"**.  
    - Similarly, add your Docker Hub token as a **"Username with Password"** credential, naming it **"dockerhub-credentials"**.
    - Similarly, add aws IAM user as **"Username with Password"** named aws-credentials.
    -Lastly, add the open weather api key as secret text called **open_weather_api_key**.




## Usage

1. **Search for a City**:
    
    - Enter a city name in the search bar (e.g., "London").
        
    - View temperature, weather description, and icon.
        
2. **View Search History**:
    
    - All previously searched cities are listed below the search bar.
        
3. **Delete a City**:
    
    - Click the "Delete" button next to any city to remove it from the history.
        

## Deployment

### CI/CD Pipeline (Jenkins)

- Run the Jenkins pipeline to:
    - Build and push the Docker image to Docker Hub.        
    - Deploy the app using Ansible.
            

### Ansible Playbook

The playbook (`playbook.yaml`) performs the following on the target server:

1. Installs and starts Docker.
    
2. Logs into Docker Hub.
    
3. Pulls the Docker image.
    
4. Runs the container on port 5000.
    

**Note**: this playbook is compatible only with AWS Linux. For other distributions, you must add the Docker repository as explained here: [Install docker](https://docs.docker.com/engine/install/)
![image](https://github.com/user-attachments/assets/962bf001-b694-474f-b5ad-ed586f13f251)

![image](https://github.com/user-attachments/assets/59b122d7-3721-4a8b-8c97-fb30899272b0)

![image](https://github.com/user-attachments/assets/cb3fd80a-837c-4f71-b51b-fea153837091)

