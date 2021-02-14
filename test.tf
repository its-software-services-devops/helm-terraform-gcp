  terraform {
    backend "gcs" {
      bucket  = "its-terraform-states"
      prefix  = "tf-its-artifact-commons-gcp"
    } 
    
    required_providers {
      google = "~> 3.4.0"
      rke = {
        version = "1.1.7"
        source = "rancher/rke"
      }
    }
  }
  provider "google" {  
    project     = "its-artifact-commons"
    region      = "asia-southeast1"
  }
  provider "rke" {
    log_file = "rke-cluster.log"
  }
  
  module "mod-its-rancher-master-01" {
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.8"
    compute_name    = "its-rancher-master-01"
    compute_seq     = ""
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
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.8"
    compute_name    = "its-rancher-master-02"
    compute_seq     = ""
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
    source          = "git::https://github.com/its-software-services-devops/tf-module-gcp-vm.git//modules?ref=1.0.8"
    compute_name    = "its-rancher-worker-01"
    compute_seq     = ""
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

  #=== RKE cluster

  resource rke_cluster "its-rancher-demo" {
    ignore_docker_version = true
    prefix_path = "/var/lib/toolbox/rke"

    nodes {
      address          = module.mod-its-rancher-master-01.instance_private_ip_addr
      internal_address = module.mod-its-rancher-master-01.instance_private_ip_addr
      user             = "cicd"
      role             = ["controlplane", "etcd"]
      ssh_key          = file("D:/dev/keys/id_rsa")
    }

    nodes {
      address          = module.mod-its-rancher-master-02.instance_private_ip_addr
      internal_address = module.mod-its-rancher-master-02.instance_private_ip_addr
      user             = "cicd"
      role             = ["controlplane", "etcd"]
      ssh_key          = file("D:/dev/keys/id_rsa")
    }

    nodes {
      address          = module.mod-its-rancher-worker-01.instance_private_ip_addr
      internal_address = module.mod-its-rancher-worker-01.instance_private_ip_addr
      user             = "cicd"
      role             = ["worker"]
      ssh_key          = file("D:/dev/keys/id_rsa")
    }
  }
  
  output its-rancher-demo-kube_config_yaml { 
    value = rke_cluster.its-rancher-demo.kube_config_yaml
  }
  
  output its-rancher-demo-rke_state { 
    value = rke_cluster.its-rancher-demo.rke_state
  }
