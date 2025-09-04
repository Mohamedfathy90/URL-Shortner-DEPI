# URL Shortener

A simple URL shortener web application built with **Laravel**, **SQLite**, and **Docker**.  
It provides a **web UI** for creating short URLs and redirecting to the original links.

---

## 🚀 Features
- Shorten any long URL into a unique short code
- Redirect short code → original URL
- Web UI with a form to submit URLs
- Persistent storage with SQLite
- Fully containerized using Docker & Docker Compose

---

## 📦 Requirements
- [Docker](https://www.docker.com/)  
- [Docker Compose](https://docs.docker.com/compose/)

---

## ⚙️ Setup & Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-repo/url-shortener.git
   cd url-shortener

2. **Start Container**
   ```bash
   docker-compose up --build -d

3. **Run migrations**
   ```bash
    docker exec -it url-shortener-app php artisan migrate

4. **Open the app in your browser:**
   👉 http://localhost:8000
