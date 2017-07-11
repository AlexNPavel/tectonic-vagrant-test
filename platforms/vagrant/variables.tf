variable "tectonic_vagrant_controller_domain" {
  type = "string"

  description = <<EOF
The domain which resolves to first controller node

Example: `c1.vagrant`
EOF
}

variable "tectonic_vagrant_controller_domains" {
  type = "list"

  description = <<EOF
Ordered list of controller domains.

Example: `["c1.vagrant", "c2.vagrant"]`
EOF
}

variable "tectonic_vagrant_ingress_domain" {
  type = "string"

  description = <<EOF
The domain which resolves to Tectonic Ingress (i.e. the first worker node)

Example: `w1.vagrant`
EOF
}

variable "tectonic_vagrant_controller_names" {
  type = "list"

  description = <<EOF
Ordered list of controller names.

Example: `["c1", "c2"]`
EOF
}
