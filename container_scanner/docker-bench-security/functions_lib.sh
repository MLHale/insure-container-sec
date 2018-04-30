#!/bin/sh

host_configuration() {
  check_1
  check_1_1
  check_1_2
  check_1_3
  check_1_4
  check_1_5
  check_1_6
  check_1_7
  check_1_8
  check_1_9
  check_1_10
  check_1_11
  check_1_12
  check_1_13
}

docker_daemon_configuration() {
  check_2
  check_2_1
  check_2_2
  check_2_3
  check_2_4
  check_2_5
  check_2_6
  check_2_7
  check_2_8
  check_2_9
  check_2_10
  check_2_11
  check_2_12
  check_2_13
  check_2_14
  check_2_15
  check_2_16
  check_2_17
  check_2_18
}

docker_daemon_files() {
  check_3
  check_3_1
  check_3_2
  check_3_3
  check_3_4
  check_3_5
  check_3_6
  check_3_7
  check_3_8
  check_3_9
  check_3_10
  check_3_11
  check_3_12
  check_3_13
  check_3_14
  check_3_15
  check_3_16
  check_3_17
  check_3_18
  check_3_19
  check_3_20
}

container_images() {
  check_4
  check_4_1
  check_4_2
  check_4_3
  check_4_4
  check_4_5
  check_4_6
  check_4_7
  check_4_8
  check_4_9
  check_4_10
  check_4_11
}

container_runtime() {
  check_5
  check_running_containers
  check_5_1
  check_5_2
  check_5_3
  check_5_4
  check_5_5
  check_5_6
  check_5_7
  check_5_8
  check_5_9
  check_5_10
  check_5_11
  check_5_12
  check_5_13
  check_5_14
  check_5_15
  check_5_16
  check_5_17
  check_5_18
  check_5_19
  check_5_20
  check_5_21
  check_5_22
  check_5_23
  check_5_24
  check_5_25
  check_5_26
  check_5_27
  check_5_28
  check_5_29
  check_5_30
  check_5_31
}

docker_security_operations() {
  check_6
  check_6_1
  check_6_2
}

docker_swarm_configuration() {
  check_7
  check_7_1
  check_7_2
  check_7_3
  check_7_5
  check_7_6
  check_7_7
  check_7_8
  check_7_9
  check_7_10
}

community_checks() {
  check_c
  check_c_1
}

# CIS
cis() {
  host_configuration
  docker_daemon_configuration
  docker_daemon_files
  container_images
  container_runtime
  docker_security_operations
  docker_swarm_configuration
}

# Community contributed
community() {
  community_checks
}

# All
all() {
  cis
  community
}
