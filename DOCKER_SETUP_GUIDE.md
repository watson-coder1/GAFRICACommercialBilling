# Docker Setup for Local Testing

## Enable Docker in WSL2

### Step 1: Open Docker Desktop
1. Open Docker Desktop on Windows
2. Click the gear icon (Settings) in the top right

### Step 2: Enable WSL2 Integration
1. Go to **Resources** → **WSL Integration**
2. Enable **"Enable integration with my default WSL distro"**
3. Enable **"Enable integration with additional distros"**
4. Select your Ubuntu distro (check the box)
5. Click **"Apply & Restart"**

### Step 3: Test Docker in WSL2
Open your WSL2 terminal and run:
```bash
docker --version
docker compose --version
```

## Once Docker is Working

### Start the Containers
```bash
cd "/mnt/c/Users/user/Desktop/Digital-Ocean-Glinta-Africa Billing System/Glinta-Hotspot-Billing-System-digital ocean with autologin"
docker compose up -d
```

### Check Container Status
```bash
docker ps
```

### Access the Application
- Open browser: http://localhost:9000
- MySQL: localhost:3307

### Run Database Optimization
```bash
# Access the container
docker exec -it nuxbill bash

# Inside container, run database optimization
mysql -h glinta-mysql -u root -p phpnuxbill < database_performance_optimization.sql
# Password: nuxbill2025!
```

### Test the Implementation
```bash
# Still inside the container
php test_modern_implementation.php
```

## Alternative: Use Windows Command Prompt

If WSL2 integration doesn't work, you can use Windows Command Prompt:

### Navigate to Project (Windows CMD)
```cmd
cd "C:\Users\user\Desktop\Digital-Ocean-Glinta-Africa Billing System\Glinta-Hotspot-Billing-System-digital ocean with autologin"
```

### Start Docker (Windows CMD)
```cmd
docker compose up -d
```

## Quick Test Without Docker

You can also test directly on your Digital Ocean server:

### SSH to Server
```bash
ssh root@your-server-ip
cd /opt/glinta-hotspot/app
```

### Pull Latest Changes
```bash
git pull origin master
```

### Run Deployment
```bash
chmod +x deploy_modern_ui.sh
./deploy_modern_ui.sh
```

### Test Implementation
```bash
php test_modern_implementation.php
```

---

**Which option would you like to try first?**
1. Fix Docker WSL2 integration
2. Use Windows Command Prompt for Docker
3. Test directly on your Digital Ocean server