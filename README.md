# odoo-docker

This is an Odoo development environment using Docker. It simplifies the process 
of initializing an Odoo project with pgAdmin.

## Features

- User is able to set specific Odoo version 
- Create a project directory with user-defined project name
- Provide a workspace folder where you can put all your addons folder (odoo-apps, extra-addons) 
- Setup environment variables for Odoo and pgAdmin
- Clone some default Odoo addons from a specific branch
- Build a Docker image with customizable tag

## Prerequisites

Before running setup.sh file, ensure that you have Python 3, Docker and Git installed

## Usage

1. Clone the repo
2. Navigate to the directory containing the repo
3. Make sure you have the right to execute the setup and dev scripts with these commands 

```bash
chmod +x setup.sh
chmod +x dev.sh
```

4. Setup the project by running

```bash
./setup.sh
```

5. The setup.sh script will ask you to enter the following informations:

- **ODOO_VERSION**: Enter the desired Odoo version (e.g., 15.0)
- **PROJECT_NAME**: Specify a name for your Odoo project
- **PGADMIN_DEFAULT_EMAIL**: Enter the default email for pgAdmin
- **PGADMIN_DEFAULT_PASSWORD**: Set the default password for pgAdmin
- **DOCKER_TAG**: Provide a custom tag for your Docker image

6. Once the setup is complete, run Odoo with the following command:
   ```bash
   ./dev.sh -d <database_name> -i <module_name>
   ```

You can now access Odoo and pgAdmin in tour browser.
