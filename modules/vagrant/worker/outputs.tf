output "ignition" {
  value = "${data.ignition_config.main.rendered}"
}

resource "local_file" "test_ign" {
  content  = "${data.ignition_config.main.rendered}"
  filename = "${var.file_name}"
}
