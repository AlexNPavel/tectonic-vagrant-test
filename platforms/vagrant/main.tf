module "ignition-masters" {
  source = "../../modules/vagrant/master"

  kubelet_node_label        = "node-role.kubernetes.io/master"
  kubelet_node_taints       = "node-role.kubernetes.io/master=:NoSchedule"
  kube_dns_service_ip       = "${module.bootkube.kube_dns_service_ip}"
  container_images          = "${var.tectonic_container_images}"
  bootkube_service          = "${module.bootkube.systemd_service}"
  tectonic_service          = "${module.tectonic.systemd_service}"
  tectonic_service_disabled = "${var.tectonic_vanilla_k8s}"
  cluster_name              = "${var.tectonic_cluster_name}"
  image_re                  = "${var.tectonic_image_re}"

  kube_image_url            = "${replace(var.tectonic_container_images["hyperkube"],var.tectonic_image_re,"$1")}"
  kube_image_tag            = "${replace(var.tectonic_container_images["hyperkube"],var.tectonic_image_re,"$2")}"

  instance_count  = "1"
  cl_channel      = "${var.tectonic_cl_channel}"
  container_image = "${var.tectonic_container_images["etcd"]}"

  base_domain  = "${var.tectonic_base_domain}"
  cluster_name = "${var.tectonic_cluster_name}"

  external_endpoints = ["${compact(var.tectonic_etcd_servers)}"]
  cluster_id         = "${module.tectonic.cluster_id}"

  tls_enabled = "${var.tectonic_etcd_tls_enabled}"

  tls_ca_crt_pem     = "${module.bootkube.etcd_ca_crt_pem}"
  tls_client_crt_pem = "${module.bootkube.etcd_client_crt_pem}"
  tls_client_key_pem = "${module.bootkube.etcd_client_key_pem}"
  tls_peer_crt_pem   = "${module.bootkube.etcd_peer_crt_pem}"
  tls_peer_key_pem   = "${module.bootkube.etcd_peer_key_pem}"

  file_name          = "master.ign"
}

#module "ignition-workers" {
#  source = "../../modules/vagrant/worker"
#
#  kubelet_node_label     = "node-role.kubernetes.io/node"
#  kubelet_node_taints    = ""
#  kube_dns_service_ip    = "${module.bootkube.kube_dns_service_ip}"
#  container_images       = "${var.tectonic_container_images}"
#  bootkube_service       = ""
#  tectonic_service       = ""
#  cluster_name           = ""
#  image_re               = "${var.tectonic_image_re}"
#
#  kube_image_url         = "${replace(var.tectonic_container_images["hyperkube"],var.tectonic_image_re,"$1")}"
#  kube_image_tag         = "${replace(var.tectonic_container_images["hyperkube"],var.tectonic_image_re,"$2")}"
#
#  instance_count = "1"
#  cl_channel      = "${var.tectonic_cl_channel}"
#  container_image = "${var.tectonic_container_images["etcd"]}"
#
#  base_domain  = "${var.tectonic_base_domain}"
#  cluster_name = "${var.tectonic_cluster_name}"
#
#  external_endpoints = ["${compact(var.tectonic_etcd_servers)}"]
#  cluster_id         = "${module.tectonic.cluster_id}"
#
#  tls_enabled = "${var.tectonic_etcd_tls_enabled}"
#
#  tls_ca_crt_pem     = "${module.bootkube.etcd_ca_crt_pem}"
#  tls_client_crt_pem = "${module.bootkube.etcd_client_crt_pem}"
#  tls_client_key_pem = "${module.bootkube.etcd_client_key_pem}"
#  tls_peer_crt_pem   = "${module.bootkube.etcd_peer_crt_pem}"
#  tls_peer_key_pem   = "${module.bootkube.etcd_peer_key_pem}"
#
#  file_name          = "worker.ign"
#}

resource "null_resource" "copy_ign" {
  depends_on = ["module.ignition-masters"]

  provisioner "local-exec" {
     command = "vagrant up --provider=virtualbox"
  }

}
