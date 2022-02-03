# typed: false
# frozen_string_literal: true

module ShopifyAPITest
  module Webhooks
    module RegistryTestQueries
      def queries
        {
          http: {
            check_query:
              <<~QUERY,
                {
                  webhookSubscriptions(first: 1, topics: some_topic) {
                    edges {
                      node {
                        id
                        endpoint {
                          __typename
                          ... on WebhookHttpEndpoint {
                            callbackUrl
                          }
                        }
                      }
                    }
                  }
                }
              QUERY

            check_empty_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [],
                },
              },
            },
            register_add_query:
              <<~QUERY,
                mutation webhookSubscription {
                  webhookSubscriptionCreate(topic: some_topic, webhookSubscription: {callbackUrl: "https://app-address.com/test-webhooks"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_add_query_with_fields:
              <<~QUERY,
                mutation webhookSubscription {
                  webhookSubscriptionCreate(topic: some_topic, webhookSubscription: {callbackUrl: "https://app-address.com/test-webhooks", includeFields: ["field1", "field2"]}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                      includeFields
                    }
                  }
                }
              QUERY

            register_add_response: {
              "data" => {
                "webhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
            register_add_with_fields_response: {
              "data" => {
                "webhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => {
                    "id" => "gid://shopify/WebhookSubscription/12345",
                    "includeFields" => ["field1", "field2"],
                  },
                },
              },
            },
            check_existing_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [
                    "node" => {
                      "id" => "gid://shopify/WebhookSubscription/12345",
                      "endpoint" => {
                        "typename" => "WebhookHttpEndpoint",
                        "callbackUrl" => "https://app-address.com/test-webhooks",
                      },
                    },
                  ],
                },
              },
            },
            register_update_query:
              <<~QUERY,
                mutation webhookSubscription {
                  webhookSubscriptionUpdate(id: "gid://shopify/WebhookSubscription/12345", webhookSubscription: {callbackUrl: "https://app-address.com/test-webhooks-updated"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_update_response: {
              "data" => {
                "webhookSubscriptionUpdate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
          },
          event_bridge: {
            check_query:
              <<~QUERY,
                {
                  webhookSubscriptions(first: 1, topics: some_topic) {
                    edges {
                      node {
                        id
                        endpoint {
                          __typename
                          ... on WebhookEventBridgeEndpoint {
                            arn
                          }
                        }
                      }
                    }
                  }
                }
              QUERY
            check_empty_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [],
                },
              },
            },
            register_add_query:
              <<~QUERY,
                mutation webhookSubscription {
                  eventBridgeWebhookSubscriptionCreate(topic: some_topic, webhookSubscription: {arn: "test-webhooks"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_add_query_with_fields:
              <<~QUERY,
                mutation webhookSubscription {
                  eventBridgeWebhookSubscriptionCreate(topic: some_topic, webhookSubscription: {arn: "test-webhooks", includeFields: ["field1", "field2"]}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                      includeFields
                    }
                  }
                }
              QUERY
            register_add_response: {
              "data" => {
                "eventBridgeWebhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
            register_add_with_fields_response: {
              "data" => {
                "eventBridgeWebhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => {
                    "id" => "gid://shopify/WebhookSubscription/12345",
                    "includeFields" => ["field1", "field2"],
                  },
                },
              },
            },
            check_existing_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [
                    "node" => {
                      "id" => "gid://shopify/WebhookSubscription/12345",
                      "endpoint" => {
                        "typename" => "WebhookEventBridgeEndpoint",
                        "arn" => "test-webhooks",
                      },
                    },
                  ],
                },
              },
            },
            register_update_query:
              <<~QUERY,
                mutation webhookSubscription {
                  eventBridgeWebhookSubscriptionUpdate(id: "gid://shopify/WebhookSubscription/12345", webhookSubscription: {arn: "test-webhooks-updated"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_update_response: {
              "data" => {
                "eventBridgeWebhookSubscriptionUpdate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
          },
          pub_sub: {
            check_query:
              <<~QUERY,
                {
                  webhookSubscriptions(first: 1, topics: some_topic) {
                    edges {
                      node {
                        id
                        endpoint {
                          __typename
                          ... on WebhookPubSubEndpoint {
                            pubSubProject
                            pubSubTopic
                          }
                        }
                      }
                    }
                  }
                }
              QUERY
            check_empty_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [],
                },
              },
            },
            register_add_query:
              <<~QUERY,
                mutation webhookSubscription {
                  pubSubWebhookSubscriptionCreate(topic: some_topic, webhookSubscription: {pubSubProject: "my-project-id", pubSubTopic: "my-topic-id"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_add_query_with_fields:
                <<~QUERY,
                  mutation webhookSubscription {
                    pubSubWebhookSubscriptionCreate(topic: some_topic, webhookSubscription: {pubSubProject: "my-project-id", pubSubTopic: "my-topic-id", includeFields: ["field1", "field2"]}) {
                      userErrors {
                        field
                        message
                      }
                      webhookSubscription {
                        id
                        includeFields
                      }
                    }
                  }
                QUERY
            register_add_response: {
              "data" => {
                "pubSubWebhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
            register_add_with_fields_response: {
              "data" => {
                "pubSubWebhookSubscriptionCreate" => {
                  "userErrors" => [],
                  "webhookSubscription" => {
                    "id" => "gid://shopify/WebhookSubscription/12345",
                    "includeFields" => ["field1", "field2"],
                  },
                },
              },
            },
            check_existing_response: {
              "data" => {
                "webhookSubscriptions" => {
                  "edges" => [
                    "node" => {
                      "id" => "gid://shopify/WebhookSubscription/12345",
                      "endpoint" => {
                        "typename" => "WebhookPubSubEndpoint",
                        "pubSubProject" => "my-project-id",
                        "pubSubTopic" => "my-topic-id",
                      },
                    },
                  ],
                },
              },
            },
            register_update_query:
              <<~QUERY,
                mutation webhookSubscription {
                  pubSubWebhookSubscriptionUpdate(id: "gid://shopify/WebhookSubscription/12345", webhookSubscription: {pubSubProject: "my-project-id", pubSubTopic: "my-topic-id-updated"}) {
                    userErrors {
                      field
                      message
                    }
                    webhookSubscription {
                      id
                    }
                  }
                }
              QUERY
            register_update_response: {
              "data" => {
                "pubSubWebhookSubscriptionUpdate" => {
                  "userErrors" => [],
                  "webhookSubscription" => { "id" => "gid://shopify/WebhookSubscription/12345" },
                },
              },
            },
          },
        }
      end
    end
  end
end
