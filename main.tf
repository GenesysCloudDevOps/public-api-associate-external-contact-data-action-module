resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "communicationId" = {
                "type" = "string"
            },
            "conversationId" = {
                "type" = "string"
            },
            "externalContactId" = {
                "type" = "string"
            },
            "mediaType" = {
                "description" = "Valid values: CALL, CALLBACK, CHAT, COBROWSE, EMAIL, MESSAGE, SOCIAL_EXPRESSION, VIDEO, SCREENSHARE",
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "PUT"
        request_url_template = "/api/v2/externalcontacts/conversations/$${input.conversationId}"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}