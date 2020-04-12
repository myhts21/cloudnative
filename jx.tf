resource "kubernetes_namespace" "jx-namespace" {
  depends_on = [google_container_node_pool.primary_preemptible_nodes]
  metadata {
    name = "jx"
  }

  lifecycle {
    ignore_changes = [metadata[0].labels, metadata[0].annotations]
  }
}

resource "kubernetes_secret" "kaniko-secret" {
  depends_on = [kubernetes_namespace.jx-namespace]
  metadata {
    name      = "kaniko-secret"
    namespace = "jx"
  }

  data = {
    "kaniko-secret" = base64decode(google_service_account_key.kaniko-sa-key.private_key)
  }
}

resource "kubernetes_secret" "vault-secret" {
  depends_on = [kubernetes_namespace.jx-namespace]
  metadata {
    name      = "vault-secret"
    namespace = "jx"
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.vault-sa-key.private_key)
  }
}
