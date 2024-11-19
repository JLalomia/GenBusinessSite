#!/bin/bash

# Function to check if Node.js is installed
function check_node_installed {
    if ! command -v node &> /dev/null; then
        echo "Node.js is not installed. Installing Node.js..."
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    else
        echo "Node.js is already installed. Version: $(node -v)"
    fi
}

# Function to create a new Node.js project
function create_node_project {
    echo "Enter project name (default: my-node-project):"
    read project_name
    project_name=${project_name:-my-node-project}
    
    # Create project directory and navigate into it
    mkdir "$project_name" && cd "$project_name"
    
    # Initialize a new Node.js project
    echo "Initializing a new Node.js project..."
    npm init -y
    
    # Install common dependencies (feel free to adjust based on project needs)
    echo "Installing Express.js as an example dependency..."
    npm install express
    
    # Set up project structure
    mkdir -p src tests public
    
    # Create a basic server file
    echo 'const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.send("Hello, world!");
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});' > src/server.js

    # Instructions for running the server
    echo "To start the server, run: node src/server.js"
    echo "Node.js project setup is complete!"
}

# Main script
echo "Setting up a new Node.js project on Ubuntu..."
check_node_installed
create_node_project