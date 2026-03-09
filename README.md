# Deploying NullClaw for Free

This directory contains the scaffolding needed to deploy [NullClaw](https://github.com/nullclaw/nullclaw) (an ultra-lightweight AI agent infrastructure) to a free VPS utilizing free AI models.

## 1. Get Free AI Model API Keys

To keep this 100% free, we configured the `config.json` to use either **Groq** (which has an incredibly generous free tier) or **Gemini** (Google's free tier).

1. **Groq**: Go to [console.groq.com](https://console.groq.com/keys) and create a free API Key.
2. **Gemini**: Go to [Google AI Studio](https://aistudio.google.com/app/apikey) to generate a free API key.

We have already set up `config.json` to load these from environment variables (`$GROQ_API_KEY` and `$GEMINI_API_KEY`).

---

## 2. Deploying (Choose your Free VPS)

You have several free options. **Fly.io** and **Render** are the easiest because they natively support Docker containers via our `Dockerfile`.

### Option A: Deploy to Render (Easiest)

Render offers a permanent free tier for Web Services.
We have set up a GitHub repository for you. Click the button below to deploy:

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/stackoverprof/nullclaw-deployment)

Alternatively, you can do it manually:

1. Go to [Render Dashboard](https://dashboard.render.com).
2. Click **New** -> **Blueprint**.
3. Connect the GitHub repository. Render will automatically read the `render.yaml` file.
4. In your Render Dashboard, go to your new service's **Environment** tab and explicitly add the `GROQ_API_KEY` (and `TELEGRAM_BOT_TOKEN` if you configured a channel).

### Option B: Deploy to Fly.io

Fly.io provides up to 3 shared-cpu VMs for free.

1. Install the `flyctl` CLI tool on your computer.
2. Run `fly auth login`.
3. In this directory, run `fly launch`. (Say "Yes" when it asks to copy the existing `fly.toml` configuration).
4. Do **not** deploy just yet. First, set your secrets securely:
   ```bash
   fly secrets set GROQ_API_KEY="your-groq-api-key"
   fly secrets set TELEGRAM_BOT_TOKEN="your-telegram-token"
   ```
5. Deploy the app:
   ```bash
   fly deploy
   ```

### Option C: Deploy to Oracle Cloud (ARM Always-Free)

Oracle provides up to 4 ARM Ampere A1 Compute instances with 24GB RAM for free.

1. Sign up for an Oracle Cloud account and create a new Compute Instance (Ubuntu 22.04 on ARM).
2. SSH into your Oracle VPS.
3. Install Docker: `sudo apt install docker.io`
4. Copy this directory to the VPS and run it via Docker:
   ```bash
   docker build -t nullclaw-app .
   docker run -d --name nullclaw -e GROQ_API_KEY="your-key" nullclaw-app
   ```
   _(Alternatively, since it's an ARM server, you could just download the `nullclaw-aarch64-linux` binary directly from their GitHub and run it without Docker to save overhead)._

---

## 3. Customizing Channels (e.g. Telegram)

If you want NullClaw to respond to you via Telegram:

1. Message [`@BotFather`](https://t.me/BotFather) on Telegram and create a new bot.
2. Copy the **Bot Token**.
3. Pass that securely into your VPS environment as `TELEGRAM_BOT_TOKEN`.

Enjoy your 100% free, lightweight AI assistant!
