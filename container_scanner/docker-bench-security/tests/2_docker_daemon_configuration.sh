#!/bin/sh

check_2() {
  logit "\n"
  info "2 - Docker daemon configuration"
}

# 2.1
check_2_1() {
  check_2_1="2.1  - Ensure network traffic is restricted between containers on the default bridge"
  totalChecks=$((totalChecks + 1))
  if get_docker_effective_command_line_args '--icc' | grep false >/dev/null 2>&1; then
    pass "$check_2_1"
    logjson "2.1" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_configuration_file_args 'icc' | grep "false" >/dev/null 2>&1; then
    pass "$check_2_1"
    logjson "2.1" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_1"
    logjson "2.1" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.2
check_2_2() {
  check_2_2="2.2  - Ensure the logging level is set to 'info'"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'log-level' >/dev/null 2>&1; then
    if get_docker_configuration_file_args 'log-level' | grep info >/dev/null 2>&1; then
      pass "$check_2_2"
      logjson "2.2" "PASS"
      currentScore=$((currentScore + 1))
    elif [ -z "$(get_docker_configuration_file_args 'log-level')" ]; then
      pass "$check_2_2"
      logjson "2.2" "PASS"
      currentScore=$((currentScore + 1))
    else
      warn "$check_2_2"
      logjson "2.2" "WARN"
      currentScore=$((currentScore - 1))
    fi
  elif get_docker_effective_command_line_args '-l'; then
    if get_docker_effective_command_line_args '-l' | grep "info" >/dev/null 2>&1; then
      pass "$check_2_2"
      logjson "2.2" "PASS"
      currentScore=$((currentScore + 1))
    else
      warn "$check_2_2"
      logjson "2.2" "WARN"
      currentScore=$((currentScore - 1))
    fi
  else
    pass "$check_2_2"
    logjson "2.2" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.3
check_2_3() {
  check_2_3="2.3  - Ensure Docker is allowed to make changes to iptables"
  totalChecks=$((totalChecks + 1))
  if get_docker_effective_command_line_args '--iptables' | grep "false" >/dev/null 2>&1; then
    warn "$check_2_3"
    logjson "2.3" "WARN"
    currentScore=$((currentScore - 1))
  elif get_docker_configuration_file_args 'iptables' | grep "false" >/dev/null 2>&1; then
    warn "$check_2_3"
    logjson "2.3" "WARN"
    currentScore=$((currentScore - 1))
  else
    pass "$check_2_3"
    logjson "2.3" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.4
check_2_4() {
  check_2_4="2.4  - Ensure insecure registries are not used"
  totalChecks=$((totalChecks + 1))
  if get_docker_effective_command_line_args '--insecure-registry' | grep "insecure-registry" >/dev/null 2>&1; then
    warn "$check_2_4"
    logjson "2.4" "WARN"
    currentScore=$((currentScore - 1))
  elif ! [ -z "$(get_docker_configuration_file_args 'insecure-registries')" ]; then
    if get_docker_configuration_file_args 'insecure-registries' | grep '\[]' >/dev/null 2>&1; then
      pass "$check_2_4"
      logjson "2.4" "PASS"
      currentScore=$((currentScore + 1))
    else
      warn "$check_2_4"
      logjson "2.4" "WARN"
      currentScore=$((currentScore - 1))
    fi
  else
    pass "$check_2_4"
    logjson "2.4" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.5
check_2_5() {
  check_2_5="2.5  - Ensure aufs storage driver is not used"
  totalChecks=$((totalChecks + 1))
  if docker info 2>/dev/null | grep -e "^Storage Driver:\s*aufs\s*$" >/dev/null 2>&1; then
    warn "$check_2_5"
    logjson "2.5" "WARN"
    currentScore=$((currentScore - 1))
  else
    pass "$check_2_5"
    logjson "2.5" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.6
check_2_6() {
  check_2_6="2.6  - Ensure TLS authentication for Docker daemon is configured"
  totalChecks=$((totalChecks + 1))
  if grep -i 'tcp://' "$CONFIG_FILE" 2>/dev/null 1>&2; then
    if [ $(get_docker_configuration_file_args '"tls":' | grep 'true') ] || \
      [ $(get_docker_configuration_file_args '"tlsverify' | grep 'true') ] ; then
      if get_docker_configuration_file_args 'tlskey' | grep -v '""' >/dev/null 2>&1; then
        if get_docker_configuration_file_args 'tlsverify' | grep 'true' >/dev/null 2>&1; then
          pass "$check_2_6"
          logjson "2.6" "PASS"
          currentScore=$((currentScore + 1))
        else
          warn "$check_2_6"
          warn "     * Docker daemon currently listening on TCP with TLS, but no verification"
          logjson "2.6" "WARN"
          currentScore=$((currentScore - 1))
        fi
      fi
    else
      warn "$check_2_6"
      warn "     * Docker daemon currently listening on TCP without TLS"
      logjson "2.6" "WARN"
      currentScore=$((currentScore - 1))
    fi
  elif get_docker_cumulative_command_line_args '-H' | grep -vE '(unix|fd)://' >/dev/null 2>&1; then
    if get_docker_cumulative_command_line_args '--tlskey' | grep 'tlskey=' >/dev/null 2>&1; then
      if get_docker_cumulative_command_line_args '--tlsverify' | grep 'tlsverify' >/dev/null 2>&1; then
        pass "$check_2_6"
        logjson "2.6" "PASS"
        currentScore=$((currentScore + 1))
      else
        warn "$check_2_6"
        warn "     * Docker daemon currently listening on TCP with TLS, but no verification"
        logjson "2.6" "WARN"
        currentScore=$((currentScore - 1))
      fi
    else
      warn "$check_2_6"
      warn "     * Docker daemon currently listening on TCP without TLS"
      logjson "2.6" "WARN"
      currentScore=$((currentScore - 1))
    fi
  else
    info "$check_2_6"
    info "     * Docker daemon not listening on TCP"
    logjson "2.6" "INFO"
    currentScore=$((currentScore +0))
  fi
}

# 2.7
check_2_7() {
  check_2_7="2.7  - Ensure the default ulimit is configured appropriately"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'default-ulimit' | grep -v '{}' >/dev/null 2>&1; then
    pass "$check_2_7"
    logjson "2.7" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_effective_command_line_args '--default-ulimit' | grep "default-ulimit" >/dev/null 2>&1; then
    pass "$check_2_7"
    logjson "2.7" "PASS"
    currentScore=$((currentScore + 1))
  else
    info "$check_2_7"
    info "     * Default ulimit doesn't appear to be set"
    logjson "2.7" "INFO"
    currentScore=$((currentScore + 0))
  fi
}

# 2.8
check_2_8() {
  check_2_8="2.8  - Enable user namespace support"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'userns-remap' | grep -v '""'; then
    pass "$check_2_8"
    logjson "2.8" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_effective_command_line_args '--userns-remap' | grep "userns-remap" >/dev/null 2>&1; then
    pass "$check_2_8"
    logjson "2.8" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_8"
    logjson "2.8" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.9
check_2_9() {
  check_2_9="2.9  - Ensure the default cgroup usage has been confirmed"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'cgroup-parent' | grep -v '""'; then
    warn "$check_2_9"
    info "     * Confirm cgroup usage"
    logjson "2.9" "INFO"
    currentScore=$((currentScore + 0))
  elif get_docker_effective_command_line_args '--cgroup-parent' | grep "cgroup-parent" >/dev/null 2>&1; then
    warn "$check_2_9"
    info "     * Confirm cgroup usage"
    logjson "2.9" "INFO"
    currentScore=$((currentScore + 0))
  else
    pass "$check_2_9"
    logjson "2.9" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.10
check_2_10() {
  check_2_10="2.10 - Ensure base device size is not changed until needed"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'storage-opts' | grep "dm.basesize" >/dev/null 2>&1; then
    warn "$check_2_10"
    logjson "2.10" "WARN"
    currentScore=$((currentScore - 1))
  elif get_docker_effective_command_line_args '--storage-opt' | grep "dm.basesize" >/dev/null 2>&1; then
    warn "$check_2_10"
    logjson "2.10" "WARN"
    currentScore=$((currentScore - 1))
  else
    pass "$check_2_10"
    logjson "2.10" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.11
check_2_11() {
  check_2_11="2.11 - Ensure that authorization for Docker client commands is enabled"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'authorization-plugins' | grep -v '\[]'; then
    pass "$check_2_11"
    logjson "2.11" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_effective_command_line_args '--authorization-plugin' | grep "authorization-plugin" >/dev/null 2>&1; then
    pass "$check_2_11"
    logjson "2.11" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_11"
    logjson "2.11" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.12
check_2_12() {
  check_2_12="2.12 - Ensure centralized and remote logging is configured"
  totalChecks=$((totalChecks + 1))
  if docker info --format '{{ .LoggingDriver }}' | grep 'json-file' >/dev/null 2>&1; then
    warn "$check_2_12"
    logjson "2.12" "WARN"
    currentScore=$((currentScore - 1))
  else
    pass "$check_2_12"
    logjson "2.12" "PASS"
    currentScore=$((currentScore + 1))
  fi
}

# 2.13
check_2_13() {
  check_2_13="2.13 - Ensure operations on legacy registry (v1) are Disabled"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'disable-legacy-registry' | grep 'true' >/dev/null 2>&1; then
    pass "$check_2_13"
    logjson "2.13" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_effective_command_line_args '--disable-legacy-registry' | grep "disable-legacy-registry" >/dev/null 2>&1; then
    pass "$check_2_13"
    logjson "2.13" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_13"
    logjson "2.13" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.14
check_2_14() {
  check_2_14="2.14 - Ensure live restore is Enabled"
  totalChecks=$((totalChecks + 1))
  if docker info 2>/dev/null | grep -e "Live Restore Enabled:\s*true\s*" >/dev/null 2>&1; then
    pass "$check_2_14"
    logjson "2.14" "PASS"
    currentScore=$((currentScore + 1))
  else
    if docker info 2>/dev/null | grep -e "Swarm:*\sactive\s*" >/dev/null 2>&1; then
      pass "$check_2_14 (Incompatible with swarm mode)"
      logjson "2.14" "PASS"
      currentScore=$((currentScore + 1))
    elif get_docker_effective_command_line_args '--live-restore' | grep "live-restore" >/dev/null 2>&1; then
      pass "$check_2_14"
      logjson "2.14" "PASS"
      currentScore=$((currentScore + 1))
    else
      warn "$check_2_14"
      logjson "2.14" "WARN"
      currentScore=$((currentScore - 1))
    fi
  fi
}

# 2.15
check_2_15() {
  check_2_15="2.15 - Ensure Userland Proxy is Disabled"
  totalChecks=$((totalChecks + 1))
  if get_docker_configuration_file_args 'userland-proxy' | grep false >/dev/null 2>&1; then
    pass "$check_2_15"
    logjson "2.15" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_effective_command_line_args '--userland-proxy=false' 2>/dev/null | grep "userland-proxy=false" >/dev/null 2>&1; then
    pass "$check_2_15"
    logjson "2.15" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_15"
    logjson "2.15" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.16
check_2_16() {
  check_2_16="2.16 - Ensure daemon-wide custom seccomp profile is applied, if needed"
  totalChecks=$((totalChecks + 1))
  if docker info --format '{{ .SecurityOptions }}' | grep 'name=seccomp,profile=default' 2>/dev/null 1>&2; then
    pass "$check_2_16"
    logjson "2.16" "PASS"
    currentScore=$((currentScore + 1))
  else
    info "$check_2_16"
    logjson "2.16" "INFO"
    currentScore=$((currentScore + 0))
  fi
}

# 2.17
check_2_17() {
  check_2_17="2.17 - Ensure experimental features are avoided in production"
  totalChecks=$((totalChecks + 1))
  if docker version -f '{{.Server.Experimental}}' | grep false 2>/dev/null 1>&2; then
    pass "$check_2_17"
    logjson "2.17" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_17"
    logjson "2.17" "WARN"
    currentScore=$((currentScore - 1))
  fi
}

# 2.18
check_2_18() {
  check_2_18="2.18 - Ensure containers are restricted from acquiring new privileges"
  totalChecks=$((totalChecks + 1))
  if get_docker_effective_command_line_args '--no-new-privileges' | grep "no-new-privileges" >/dev/null 2>&1; then
    pass "$check_2_18"
    logjson "2.18" "PASS"
    currentScore=$((currentScore + 1))
  elif get_docker_configuration_file_args 'no-new-privileges' | grep true >/dev/null 2>&1; then
    pass "$check_2_18"
    logjson "2.18" "PASS"
    currentScore=$((currentScore + 1))
  else
    warn "$check_2_18"
    logjson "2.18" "WARN"
    currentScore=$((currentScore - 1))
  fi
}
