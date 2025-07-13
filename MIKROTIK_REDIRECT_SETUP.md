# MikroTik Hotspot Redirect Page Setup

## 🎨 Enhanced Redirect Pages

I've created three versions of the redirect page with gold theme and dynamic animations:

### 1. **Full Version** (`mikrotik-redirect.html`)
- **Size**: ~8KB
- **Features**: Full animations, particle effects, sparkles, premium design
- **Best for**: Modern routers with more storage

### 2. **Minified Version** (`mikrotik-redirect-minified.html`)
- **Size**: ~4KB
- **Features**: All animations but compressed code
- **Best for**: Standard MikroTik installations

### 3. **Simple Version** (`mikrotik-redirect-simple.html`)
- **Size**: ~2KB
- **Features**: Basic animations, fast loading, gold theme
- **Best for**: Older routers or minimal resources

---

## 📋 Features in All Versions

✅ **Gold Theme** - Premium Glinta branding with gold (#FFD700) accents  
✅ **Fast Redirect** - 2-3 second automatic redirect  
✅ **Animated Logo** - Pulsing "G" logo with gold gradient  
✅ **Loading Animation** - Spinning loader with progress bar  
✅ **Kenya Colors** - Black, green, and gold gradient background  
✅ **Mobile Responsive** - Works on all devices  
✅ **Professional Look** - Modern, clean design  

---

## 🚀 How to Upload to MikroTik

### Method 1: Using Winbox
1. Open Winbox and connect to your MikroTik router
2. Go to **Files** in the left menu
3. Drag and drop one of the HTML files to the file list
4. Go to **IP → Hotspot → Server Profiles**
5. Double-click your hotspot profile
6. In the **Login** tab, set:
   - **Login By**: HTTP PAP
   - **HTTP PAP**: Always
   - **Login Page**: Select your uploaded HTML file

### Method 2: Using Terminal
```bash
# Upload via FTP
ftp 192.168.88.1
ftp> put mikrotik-redirect-simple.html
ftp> quit

# Or via SCP
scp mikrotik-redirect-simple.html admin@192.168.88.1:/
```

### Method 3: Using WebFig
1. Access router via web browser: http://192.168.88.1
2. Go to **Files**
3. Click **Upload** and select the HTML file
4. Configure in **IP → Hotspot → Server Profiles**

---

## 🔧 MikroTik Configuration

### Set as Login Page
```mikrotik
/ip hotspot profile
set [find name="your-profile"] login-by=http-pap http-pap=always \
    html-directory=flash/hotspot login=mikrotik-redirect-simple.html
```

### Alternative: Set as Splash Page
```mikrotik
/ip hotspot profile
set [find name="your-profile"] login-by=mac trial-uptime-limit=3s \
    html-directory=flash/hotspot login=mikrotik-redirect-simple.html
```

---

## 🎯 Choosing the Right Version

### Use **Full Version** if:
- You have RouterBoard with 16MB+ storage
- You want maximum visual impact
- Your customers use modern devices

### Use **Minified Version** if:
- Standard RouterBoard installation
- Balance between features and size
- Most common choice

### Use **Simple Version** if:
- Limited storage space
- Older RouterBoard models
- Need fastest loading time
- Recommended for most deployments

---

## 🔍 Customization

To change redirect URL or timing:

1. **Change URL**: 
   ```html
   window.location.href = "http://glintaafrica.com/portal";
   ```
   Change to your portal URL

2. **Change Timing** (in milliseconds):
   ```javascript
   setTimeout(() => {
       window.location.href = "http://glintaafrica.com/portal";
   }, 2000); // 2000ms = 2 seconds
   ```

3. **Change Meta Refresh**:
   ```html
   <meta http-equiv="refresh" content="2;url=http://glintaafrica.com/portal">
   ```
   Change `2` to desired seconds

---

## 📱 Preview

The redirect page features:
- **Gold "G" logo** with pulsing animation
- **"Welcome to Glinta WiFi"** heading in gold
- **Premium Internet Solutions** tagline
- **Animated loading spinner**
- **Progress bar** showing redirect progress
- **Features icons**: ⚡ Fast | 🔒 Secure | 💎 Premium
- **Countdown timer** showing seconds until redirect

---

## 🛠️ Troubleshooting

### Page Not Loading
- Check file is uploaded to router
- Verify hotspot profile settings
- Ensure file permissions are correct

### Redirect Not Working
- Check portal URL is accessible
- Verify network connectivity
- Test with direct URL access

### Styling Issues
- Use simple version for older devices
- Check browser compatibility
- Verify UTF-8 encoding

---

## 🎉 Result

Your customers will see a beautiful, professional redirect page with:
- Gold-themed Glinta branding
- Smooth animations
- Quick 2-second redirect
- Mobile-friendly design
- Premium feel that matches your service quality

The page creates a great first impression while quickly redirecting users to purchase internet packages!