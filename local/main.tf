# local/main.tf -- the laptop demo: page rendered + nginx container + port map.
#
#   1. Render index.html from the shared template (root of the repo).
#   2. Pull the pinned nginx image.
#   3. Run the container: host port -> container port 80, page mounted read-only.

resource "local_file" "index_html" {
  filename = "${path.module}/index.html"
  content = templatefile("${path.module}/../index.html.tpl", {
    title      = var.site_title
    host_label = "Docker on this laptop"
    engine     = var.engine
  })
}

resource "docker_image" "nginx" {
  name         = var.engine
  keep_locally = true
}

resource "docker_container" "web" {
  name    = "demo-website"
  image   = docker_image.nginx.image_id
  restart = "unless-stopped"

  ports {
    internal = 80
    external = var.http_port
  }

  volumes {
    host_path      = abspath("${path.module}/index.html")  # rendered by local_file
    container_path = "/usr/share/nginx/html/index.html"
    read_only      = true
  }

  depends_on = [local_file.index_html]
}
