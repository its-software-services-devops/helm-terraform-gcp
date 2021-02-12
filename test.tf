  terraform {
    required_providers {
      google = "~> 3.4.0"
    }

    backend "gcs" {
      bucket  = "its-terraform-states"
      prefix  = "tf-its-artifact-commons-gcp"
    }  
  }

  provider "google" {  
    project     = "its-artifact-commons"
    region      = "asia-southeast1"
    
    #credentials = file("D:/dev/keys/its-artifact-commons-6eb8e8c315b3.json")
  }

  module "mod-its-rancher-manager-01" {
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.6"
    compute_name    = "its-rancher-manager-01"
    compute_seq     = "00"
    vm_tags         = ["k8s-manager"]
    vm_service_account = "devops-cicd@its-artifact-commons.iam.gserviceaccount.com"
    boot_disk_image  = "projects/centos-cloud/global/images/centos-7-v20200910"
    boot_disk_size   = 100
    public_key_file  = "D:/dev/keys/id_rsa.pub"
    private_key_file = "D:/dev/keys/id_rsa"
    vm_machine_type  = "e2-small"
    vm_machine_zone  = "asia-southeast1-b"
    vm_deletion_protection = false
    ssh_user         = "cicd"
    provisioner_local_path  = "scripts/provisioner.bash"
    provisioner_remote_path = "/home/cicd"
    external_disks   = []
    network_configs  = [{index = 1, network = "default", nat_ip = ""}]
    create_nat_ip = true
  }
  
  module "mod-its-rancher-master-01" {
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.6"
    compute_name    = "its-rancher-master-01"
    compute_seq     = "00"
    vm_tags         = ["k8s-master"]
    vm_service_account = "devops-cicd@its-artifact-commons.iam.gserviceaccount.com"
    boot_disk_image  = "projects/cos-cloud/global/images/cos-beta-89-16108-0-69"
    boot_disk_size   = 100
    public_key_file  = "D:/dev/keys/id_rsa.pub"
    private_key_file = "D:/dev/keys/id_rsa"
    vm_machine_type  = "e2-small"
    vm_machine_zone  = "asia-southeast1-b"
    vm_deletion_protection = false
    ssh_user         = "cicd"
    provisioner_local_path  = "scripts/provisioner.bash"
    provisioner_remote_path = "/home/cicd"
    external_disks   = []
    network_configs  = [{index = 1, network = "default", nat_ip = ""}]
    create_nat_ip = false
  }
  
  module "mod-its-rancher-master-02" {
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.6"
    compute_name    = "its-rancher-master-02"
    compute_seq     = "00"
    vm_tags         = ["k8s-master"]
    vm_service_account = "devops-cicd@its-artifact-commons.iam.gserviceaccount.com"
    boot_disk_image  = "projects/cos-cloud/global/images/cos-beta-89-16108-0-69"
    boot_disk_size   = 100
    public_key_file  = "D:/dev/keys/id_rsa.pub"
    private_key_file = "D:/dev/keys/id_rsa"
    vm_machine_type  = "e2-small"
    vm_machine_zone  = "asia-southeast1-b"
    vm_deletion_protection = false
    ssh_user         = "cicd"
    provisioner_local_path  = "scripts/provisioner.bash"
    provisioner_remote_path = "/home/cicd"
    external_disks   = []
    network_configs  = [{index = 1, network = "default", nat_ip = ""}]
    create_nat_ip = false
  }
  
  module "mod-its-rancher-worker-01" {
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.6"
    compute_name    = "its-rancher-worker-01"
    compute_seq     = "00"
    vm_tags         = ["k8s-worker"]
    vm_service_account = "devops-cicd@its-artifact-commons.iam.gserviceaccount.com"
    boot_disk_image  = "projects/cos-cloud/global/images/cos-beta-89-16108-0-69"
    boot_disk_size   = 100
    public_key_file  = "D:/dev/keys/id_rsa.pub"
    private_key_file = "D:/dev/keys/id_rsa"
    vm_machine_type  = "e2-small"
    vm_machine_zone  = "asia-southeast1-b"
    vm_deletion_protection = false
    ssh_user         = "cicd"
    provisioner_local_path  = "scripts/provisioner.bash"
    provisioner_remote_path = "/home/cicd"
    external_disks   = []
    network_configs  = [{index = 1, network = "default", nat_ip = ""}]
    create_nat_ip = false
  }
