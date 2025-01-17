paas_space                    = "get-into-teaching-production"
paas_monitoring_space         = "get-into-teaching-monitoring"
paas_monitoring_app           = "prometheus-prod-get-into-teaching"
paas_adviser_application_name = "get-teacher-training-adviser-service-prod"
paas_adviser_route_name       = "get-teacher-training-adviser-service-prod"
paas_linked_services          = ["get-into-teaching-prod-redis-svc", "get-into-teaching-api-prod-pg-common-svc"]
paas_additional_route_names   = ["beta-adviser-getintoteaching", "adviser-getintoteaching"]
logging                       = 1
instances                     = 2
basic_auth                    = 0
azure_key_vault               = "s146p01-kv"
azure_resource_group          = "s146p01-rg"
alerts = {
  GiT_TTA_Production_Healthcheck = {
    website_name  = "Get Into Teaching Adviser (Production)"
    website_url   = "https://adviser-getintoteaching.education.gov.uk/healthcheck.json"
    check_rate    = 60
    contact_group = [185037]
  }
}
