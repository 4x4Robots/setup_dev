Perfect — then let’s design a **clean, explicit, reproducible `pushall` workflow** that fits your style: minimal magic, maximum clarity, and zero hidden automation. I’ll give you a structured setup that you can drop into your dotfiles and reuse across machines.

Below is a complete workflow with:

- a safe `pushall` alias  
- a guard that warns when you accidentally run `git push`  
- a reproducible remote setup  
- optional auto‑creation of missing backup repos  
- a small “health check” command to verify everything works  

This keeps things disciplined but friction‑free.

---

# 🧭 1. Define the `pushall` Alias

Add this to your global `~/.gitconfig`:

```ini
[alias]
    pushall = "!git push origin && git push backup"
```

This ensures:

- GitHub push happens first  
- Backup push happens second  
- If GitHub fails, the backup is not attempted  
- If the backup fails, you see it immediately  

---

# 🛡️ 2. Add a Guard for `git push`

You want to avoid accidentally running `git push` out of habit.  
We don’t *block* it (that’s too harsh), but we warn loudly.

Add this to your global config:

```ini
[alias]
    push = "!echo '⚠️  Use `git pushall` instead to back up your repo.' && exit 1"
```

This makes `git push` fail with a clear message.

If you *really* need to push only to origin, you can still run:

```bash
git push origin
```

This keeps the workflow explicit.

---

# 🧱 3. Standardize the Backup Remote

Every repo needs a `backup` remote pointing to your local server.

You can add this once per repo:

```bash
git remote add backup ssh://yourserver/home/git/<repo>.git
```

But since you like reproducibility, I recommend a tiny helper script:

### `git-setup-backup` (placed in your PATH)

```bash
#!/usr/bin/env bash
set -euo pipefail

repo_name=$(basename "$(git rev-parse --show-toplevel)")
backup_url="ssh://yourserver/home/git/${repo_name}.git"

git remote remove backup 2>/dev/null || true
git remote add backup "$backup_url"

echo "Backup remote set to: $backup_url"
```

Now you can run:

```bash
git setup-backup
```

…in any repo, and it configures the correct remote.

---

# 🧩 4. Optional: Auto‑Create Missing Backup Repos

If you want to avoid manually creating bare repos on the server, add a small server‑side script.

### On the server: `/usr/local/bin/git-init-bare`

```bash
#!/usr/bin/env bash
set -euo pipefail

repo="$1"

mkdir -p /home/git
cd /home/git

if [ ! -d "$repo.git" ]; then
    git init --bare "$repo.git"
    echo "Created bare repo: $repo.git"
fi
```

### Then allow your client to trigger it via SSH:

In your client script:

```bash
ssh yourserver git-init-bare "$repo_name"
```

Integrate this into `git-setup-backup`:

```bash
ssh yourserver git-init-bare "$repo_name"
git remote add backup "$backup_url"
```

Now the workflow is:

```bash
git setup-backup
git pushall
```

…and the server repo is created automatically if missing.

---

# 🧪 5. Add a “Backup Health Check” Command

This is optional but very nice for peace of mind.

Add to your `~/.gitconfig`:

```ini
[alias]
    backup-status = "!git remote show backup"
```

Run:

```bash
git backup-status
```

This shows:

- whether the remote is reachable  
- which branches are synced  
- whether you’re ahead/behind  

Great for debugging.

---

# 🧭 6. Final Workflow Summary

Here’s how your daily workflow looks:

### **Initial setup (once per repo)**

```bash
git setup-backup
```

### **Daily pushing**

```bash
git pushall
```

### **If you accidentally run `git push`**

You get a friendly warning.

### **If you want to check the backup**

```bash
git backup-status
```

### **If you clone a new repo**

```bash
git setup-backup
```

---

# 🧠 Why This Workflow Works So Well

- **Explicit**: You always know what’s happening.  
- **Reproducible**: Works across machines and repos.  
- **Safe**: No hidden hooks, no push loops.  
- **Minimal**: No servers exposed to the internet.  
- **Extendable**: When you add Gitea later, you can keep or retire this workflow.

It’s very much aligned with your preference for clarity, atomicity, and predictable behavior.

---

If you want, I can help you turn this into a **formal design document** with:

- architecture  
- rationale  
- alternatives considered  
- risks  
- future evolution (Gitea phase)  

Just say the word.

