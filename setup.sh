#!/bin/bash

echo "odoo-docker project setup, initializing..."

# User input to initialize the project
read -p "Enter ODOO_VERSION: " ODOO_VERSION
read -p "Enter PROJECT_NAME: " PROJECT_NAME
read -p "Enter PGADMIN_DEFAULT_EMAIL: " PGADMIN_DEFAULT_EMAIL
read -p "Enter PGADMIN_DEFAULT_PASSWORD: " PGADMIN_DEFAULT_PASSWORD
read -p "Enter Docker image tag name: " DOCKER_TAG

# Create a .env file based on user input
cat <<EOF > .env
ODOO_VERSION=$ODOO_VERSION
PROJECT_NAME=$PROJECT_NAME
PGADMIN_DEFAULT_EMAIL=$PGADMIN_DEFAULT_EMAIL
PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD
DOCKER_TAG=$DOCKER_TAG
EOF

# Create the "workspace" directory
mkdir -p workspace

# Create the requirements.txt file inside the "workspace" directory
cat <<EOF > workspace/requirements.txt
# Add your Python package dependencies here
# Example: package_name==version
EOF

echo "Downloading default addons from github.com/abdounasser202/odoo-apps branch $ODOO_VERSION. Please wait..."

# Clone the repository if the specified branch ($ODOO_VERSION) exists, else, pass
if git ls-remote --heads https://github.com/abdounasser202/odoo-apps.git $ODOO_VERSION | grep -q $ODOO_VERSION; then
  git clone --single-branch --branch $ODOO_VERSION https://github.com/abdounasser202/odoo-apps.git workspace/odoo-apps
fi

# Create the Dockerfile
cat <<EOF > Dockerfile
FROM odoo:$ODOO_VERSION

USER root

COPY ./workspace/requirements.txt /tmp/requirements.txt

RUN pip3 install --upgrade pip \\
    && pip3 install debugpy \\
    && pip3 install -r /tmp/requirements.txt

COPY ./workspace /mnt

USER odoo
EOF

# Build the Docker image with the provided tag name
docker build -t $DOCKER_TAG .

echo "Docker image built with ODOO_VERSION: $ODOO_VERSION, PROJECT_NAME: $PROJECT_NAME, PGADMIN_DEFAULT_EMAIL: $PGADMIN_DEFAULT_EMAIL, PGADMIN_DEFAULT_PASSWORD: $PGADMIN_DEFAULT_PASSWORD, and tagged as $DOCKER_TAG"

echo "Now you can run './dev.sh -d <database_name> -i <module_name>'  to install your first module and run Odoo"