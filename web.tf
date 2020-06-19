provider "kubernetes" {
  config_context_cluster   = "minikube"

}
resource "kubernetes_deployment" "deploy" {
  metadata {
    name = "rs1"
  }
  spec {
    replicas = 3

    selector {
      match_labels = {
        env = "dev"
        dc = "IN"
        app = "webserver"
      }

      match_expressions { 
          
        key = "dc"
        operator = "In"
        values = ["IN","US"] 
          
         }

      match_expressions { 
          
        key = "env"
        operator = "In"
        values = ["dev" , "prod"]
          
         }

      match_expressions { 
          
        key = "app"
        operator = "In"
        values = ["webserver"]
          
         }
  
    }

    template {
      metadata {
        name = "mypod1"
        labels = {
          env = "dev"
          dc =  "IN"
          app = "webserver"
        }
      }

      spec {
        container {
          image = "vimal13/apache-webserver-php"
          name  = "mycon"
        }
      }
    }
  }
}
