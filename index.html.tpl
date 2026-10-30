<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${title}</title>
  <style>
    body { font-family: system-ui, sans-serif; display: grid; place-items: center; min-height: 100vh; margin: 0; background: #0f172a; color: #e2e8f0; }
    .card { max-width: 640px; padding: 3rem; text-align: center; border: 1px solid #334155; border-radius: 16px; background: #1e293b; }
    h1 { margin: 0 0 0.5rem; font-size: 2rem; }
    p { color: #94a3b8; line-height: 1.6; }
    code { background: #0f172a; padding: 0.2rem 0.5rem; border-radius: 6px; color: #7dd3fc; }
  </style>
</head>
<body>
  <div class="card">
    <h1>${title}</h1>
    <p>This page is live because a Terraform plan described the infrastructure
       and executed it.</p>
    <p>Where it runs: <code>${host_label}</code> &middot; Engine: <code>${engine}</code></p>
  </div>
</body>
</html>
