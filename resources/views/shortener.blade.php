<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>URL Shortener</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex flex-column justify-content-center align-items-center vh-100">

<div class="card shadow p-4 text-center" style="width: 500px;">
    <!-- Logo -->
    <img src="{{ asset('images/depi-logo.png') }}" alt="DEPI Logo" class="mb-3" style="height:180px;width: 180px;margin: auto;">

    <h2 class="mb-3">URL Shortener (DEPI Graduation Project)</h2>

    <form method="POST" action="/shorten">
        @csrf
        <div class="mb-3 text-start">
            <label for="url" class="form-label">Enter Long URL</label>
            <input type="url" class="form-control" id="url" name="url" placeholder="https://example.com" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Shorten</button>
    </form>

    @if(isset($shortUrl))
        <div class="alert alert-success mt-3 text-center">
            Short URL: <a href="{{ $shortUrl }}" target="_blank">{{ $shortUrl }}</a>
        </div>
    @endif
</div>

</body>
</html>
