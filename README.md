# Terraform Scripts for Overpass API Deployment

This repository contains a set of Terraform scripts that aid in deploying the
Overpass API to different Infrastructure-as-a-Service (IAAS) providers. These
scripts are not meant for production use, but rather for provisioning temporary
environments for testing or development purposes.

## Features

The provided Terraform scripts enable the following features:

- Deploying Overpass API to various IAAS providers
- Configuring necessary infrastructure components like containers, storage
  accounts, and droplets
- Specifying custom configurations for the deployed Overpass API instances

## Example Usage

### Azure Container Instance (ACI)

To deploy Overpass API using Azure Container Instance (ACI), follow these steps:

1. Navigate to the `azure` directory within the repository.

2. Open the `main.tf` file and update the necessary variables, such as the
   resource group name and container image.

3. Run the following commands in the terminal within the `azure` directory:

   ```shell
   terraform init
   terraform apply
   ```

4. After the deployment is complete, refer to the output to obtain the IP
   address of the deployed Azure Container Instance.

### DigitalOcean Droplet

To deploy Overpass API using DigitalOcean Droplet, follow these steps:

1. Navigate to the `digitalocean` directory within the repository.

1. Run the following commands in the terminal within the `digitalocean`
   directory:

   ```bash
   brew bundle
   bundle install

   # setup digital ocean CLI access
   # get token from https://cloud.digitalocean.com/account/api/tokens
   export DIGITAL_OCEAN_API_KEY=""

   cd digitalocean
   # create the droplet
   rake droplet:create

   # deploy resources on to the droplet
   rake droplet:deploy

   # delete the droplet
   rake droplet:destroy
   ```

1. After the deployment is complete, refer to the output to obtain the IPv4
   address of the deployed DigitalOcean Droplet.

## Contributing

Contributions to this repository are welcome. If you find any issues or have
ideas for improvements, please submit a pull request or open an issue on GitHub.

## License

This codebase is open source and is distributed under the
[MIT License](LICENSE).
