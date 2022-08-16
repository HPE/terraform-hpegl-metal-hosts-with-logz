input {
  beats {
    port => "5044"
  }
}

filter {
  mutate {
    add_field => { "token" => ${ TF_LOGZIO_SHIP_TOKEN } }
  }
}

output {
  tcp {
    host => "${TF_LOGZIO_SERVICE_URL}"
    port => ${TF_LOGZIO_SERVICE_PORT}
    codec => json_lines
  }
}