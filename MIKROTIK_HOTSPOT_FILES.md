# MikroTik Hotspot Files - Complete Setup Guide

## 🎯 Understanding MikroTik Hotspot Files

### File Structure in MikroTik:
```
/flash/hotspot/
├── login.html       → Main login page (where users authenticate)
├── redirect.html    → Initial redirect when connecting to WiFi
├── status.html      → Shows after successful login
├── logout.html      → Logout page
├── error.html       → Error messages
└── md5.js          → For CHAP authentication
```

## 📦 What You Need to Upload

### 1. **redirect.html** (Initial Connection)
- **Use**: `mikrotik-redirect-simple.html` (rename to `redirect.html`)
- **Purpose**: Shows briefly when user first connects to WiFi
- **Features**: Gold theme, 2-second redirect to login page

### 2. **login.html** (Main Portal)
- **Use**: `mikrotik-login.html` (already named correctly)
- **Purpose**: Main page where users select packages and pay
- **Features**: Package selection, M-Pesa payment form

### 3. **status.html** (Success Page)
- **Create from**: Your `portal-success.tpl`
- **Purpose**: Shows after successful payment
- **Features**: Success message, internet access confirmation

## 🚀 Step-by-Step Upload Instructions

### Step 1: Prepare Files
```bash
# Rename files for MikroTik
cp mikrotik-redirect-simple.html redirect.html
cp mikrotik-login.html login.html
# status.html needs to be created (optional)
```

### Step 2: Upload via Winbox
1. Open **Winbox** and connect to your MikroTik
2. Click **Files** in the left menu
3. Navigate to `/flash/hotspot/` (or create it)
4. Drag and drop:
   - `redirect.html`
   - `login.html`
   - `md5.js` (if using CHAP)

### Step 3: Configure Hotspot Profile
1. Go to **IP → Hotspot → Server Profiles**
2. Double-click your profile (e.g., "hsprof1")
3. In **General** tab:
   - HTML Directory: `flash/hotspot`
4. In **Login** tab:
   - Login By: `HTTP PAP`
   - HTTP PAP: `always`

### Step 4: Configure Walled Garden (IMPORTANT!)
Allow access to your payment portal:
```mikrotik
/ip hotspot walled-garden
add dst-host="glintaafrica.com" action=allow
add dst-host="*.glintaafrica.com" action=allow
add dst-host="api.safaricom.co.ke" action=allow comment="Mpesa API"
add dst-host="*.safaricom.co.ke" action=allow comment="Mpesa"
```

## 🔧 MikroTik Configuration Commands

### Complete Setup via Terminal:
```mikrotik
# 1. Create hotspot directory (if not exists)
/file print where name="flash/hotspot"

# 2. Set hotspot profile
/ip hotspot profile
set [find name="hsprof1"] html-directory=flash/hotspot login-by=http-pap

# 3. Add walled garden entries
/ip hotspot walled-garden
add dst-host="glintaafrica.com" action=allow
add dst-host="api.safaricom.co.ke" action=allow

# 4. Set redirect settings
/ip hotspot profile
set [find name="hsprof1"] login-by=http-pap http-pap=always
```

## ⚠️ Important Differences

### Your System vs Standard MikroTik:
1. **Your Portal**: Full PHP application at `glintaafrica.com/portal`
2. **MikroTik Login**: Static HTML that redirects to your portal
3. **Payment Processing**: Happens on your server, not MikroTik

### Flow Explanation:
```
1. User connects to WiFi
   ↓
2. MikroTik shows redirect.html (2 seconds)
   ↓
3. Redirects to login.html
   ↓
4. User fills form → Submits to YOUR portal
   ↓
5. Your portal handles M-Pesa payment
   ↓
6. After payment, your system creates MikroTik user
   ↓
7. User can now browse internet
```

## 🎨 Customization Tips

### To modify login.html packages:
```html
<!-- Edit these sections in mikrotik-login.html -->
<div class="package-card" onclick="selectPackage(this, 'PACKAGE_ID', PRICE)">
    <div class="package-header">
        <span class="package-name">Package Name</span>
        <span class="package-price">KSh PRICE</span>
    </div>
    <div class="package-details">
        ⏱️ Duration • 🚀 Speed • 📱 Features
    </div>
</div>
```

### To change redirect URL:
```html
<!-- In redirect.html -->
<meta http-equiv="refresh" content="2;url=http://glintaafrica.com/portal">

<!-- And in JavaScript -->
window.location.href = "http://glintaafrica.com/portal";
```

## 🔍 Testing Your Setup

1. **Connect a test device** to hotspot WiFi
2. **Open browser** - Should see redirect.html briefly
3. **Get redirected** to login.html
4. **Select package** and enter phone number
5. **Submit form** - Should go to your portal
6. **Complete payment** - Should get internet access

## 🛠️ Troubleshooting

### "Page not found" error:
- Check files are in `/flash/hotspot/`
- Verify HTML directory in hotspot profile
- Ensure file permissions are correct

### Not redirecting to portal:
- Check walled garden entries
- Verify portal URL is accessible
- Test DNS resolution

### Form not submitting:
- Check $(link-login-only) variable
- Verify HTTP PAP is enabled
- Check JavaScript console for errors

## 📝 Alternative Approach

If you want MikroTik to handle EVERYTHING (no external portal):

1. **Use built-in user manager**
2. **Create local users with passwords**
3. **Use voucher system**
4. **Simple login.html with username/password**

But your current approach (external portal + M-Pesa) is more advanced and better!

## 🎉 Summary

1. **redirect.html** = Quick splash screen (gold themed)
2. **login.html** = Package selection form
3. **Your portal** = Handles actual payment and user creation
4. **MikroTik** = Enforces access control

The files I created work together to provide a seamless, professional hotspot experience!