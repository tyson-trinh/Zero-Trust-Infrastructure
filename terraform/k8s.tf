resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "gcloud beta container clusters get-credentials ${module.gke_cluster.name} --region ${var.region} --project ${var.project}"

    environment = {
      KUBECONFIG = var.kubectl_config_path != "" ? var.kubectl_config_path : ""
    }
  }

  depends_on = [google_container_node_pool.node_pool]
}

resource "kubernetes_cluster_role_binding" "user" {
  metadata {
    name = "admin-user"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "User"
    name      = data.google_client_openid_userinfo.terraform_user.email
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "helm_release" "kong" {
  depends_on = [google_container_node_pool.node_pool]
  namespace = "kong"
  repository = "https://charts.konghq.com"
  name       = "kong"
  chart      = "kong"
}

resource "helm_release" "argocd" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.argocd]

  repository = "https://argoproj.github.io/argo-helm"
  name       = "argocd"
  chart      = "argocd"
}

resource "helm_release" "kube-prometheus-stack" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.monitoring]

  repository = "https://prometheus-community.github.io/helm-charts"
  name       = "kube-prometheus-stack"
  chart      = "kube-prometheus-stack"
}

resource "helm_release" "elasticsearch" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.monitoring]

  repository = "https://helm.elastic.co"
  name       = "elasticsearch"
  chart      = "elasticsearch"
}

resource "helm_release" "filebeat" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.monitoring]

  repository = "https://helm.elastic.co"
  name       = "filebeat"
  chart      = "filebeat"
}

resource "helm_release" "mongodb" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.monitoring]

  repository = "https://charts.bitnami.com/bitnami"
  name       = "mongodb-sharded"
  chart      = "mongodb-sharded"
}

resource "helm_release" "vault" {
  depends_on = [google_container_node_pool.node_pool, kubernetes_namespace.vault]

  repository = "https://helm.releases.hashicorp.com"
  name       = "vault"
  chart      = "vault"
}

resource "kubernetes_namespace" "backend" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }
    name = "backend"
  }
}

resource "kubernetes_namespace" "mongodb" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }
    name = "mongodb"
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "developing" {
  metadata {
    name = "developing"
  }
}

resource "kubernetes_namespace" "istio" {
  metadata {
    name = "istio"
  }
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}



