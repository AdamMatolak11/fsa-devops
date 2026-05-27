# SkillMarket Keycloak Theme - Quick Start Guide

Get your custom Keycloak theme up and running in 5 minutes!

## TL;DR (Fastest Setup)

```bash
# For Local Keycloak:
cp -r keycloak-theme $KEYCLOAK_HOME/themes/skillmarket
# Then restart Keycloak and apply theme in Admin Console

# For Docker:
docker cp keycloak-theme <container-id>:/opt/keycloak/themes/skillmarket
docker restart <container-id>
```

## Step-by-Step Quick Start

### 1. Copy Theme (30 seconds)

**For Keycloak Standalone:**
```bash
cp -r keycloak-theme /path/to/keycloak/themes/skillmarket
```

**For Docker Container:**
```bash
docker cp keycloak-theme my-keycloak:/opt/keycloak/themes/skillmarket
docker restart my-keycloak
```

**For Docker Compose:**
```yaml
volumes:
  - ./keycloak-theme:/opt/keycloak/themes/skillmarket
```

### 2. Restart Keycloak (1 minute)

```bash
# Standalone
$KEYCLOAK_HOME/bin/kc.sh start

# Docker
docker restart my-keycloak

# Kubernetes
kubectl rollout restart deployment/keycloak -n keycloak
```

### 3. Apply Theme (2 minutes)

1. Go to `http://localhost:8080/admin` (or your Keycloak URL)
2. Select your realm (top-left dropdown)
3. Click **Realm Settings**
4. Go to **Themes** tab
5. Set:
   - **Login Theme**: `skillmarket`
   - **Account Theme**: `skillmarket-account`
6. Click **Save**

### 4. Test (1 minute)

1. Go to login page: `http://localhost:8080/realms/your-realm/account/`
2. You should see the new dark slate theme with cyan accents
3. Try logging in to verify forms work

## Visual Overview

```
Login Page Flow:
1. Modern dark header with logo
2. Centered login form with icons
3. Social provider buttons (if enabled)
4. Responsive design (works on mobile)
5. Dark slate primary (#1E293B) + Cyan secondary (#0EA5E9)
```

## What's Included

| Component | Files | Status |
|-----------|-------|--------|
| **Login** | `login.ftl`, `login.css` | ✅ Ready |
| **Register** | `register.ftl`, `login.css` | ✅ Ready |
| **Password** | `login-password.ftl` | ✅ Ready |
| **Error** | `error.ftl`, `login.css` | ✅ Ready |
| **Account** | `account.ftl`, `account.css` | ✅ Ready |
| **Responsive** | All templates | ✅ Ready |
| **Dark Mode** | All CSS files | ✅ Ready |

## Key Features

✨ **Design**
- Modern, clean interface
- Dark slate primary color (#1E293B)
- Cyan secondary accents (#0EA5E9)
- Professional typography (Plus Jakarta Sans)
- Smooth animations and transitions

🎨 **Components**
- Login form with icons
- Registration with validation
- Account management dashboard
- Error pages
- Social provider support

📱 **Responsive**
- Desktop (1200px+)
- Tablet (768px-1199px)
- Mobile (< 768px)
- Full Bootstrap 5 support

🌙 **Dark Mode**
- Automatic dark mode detection
- CSS media query support
- Accessible color contrast

## File Structure

```
keycloak-theme/
├── README.md                    # Full documentation
├── INSTALLATION.md              # Deployment guide
├── QUICKSTART.md               # This file
├── theme.properties            # Root config
│
├── login/                       # Login theme
│   ├── theme.properties        # Login config
│   ├── template.ftl            # Base layout
│   ├── login.ftl               # Login form
│   ├── register.ftl            # Registration form
│   ├── login-password.ftl      # Password-only login
│   ├── error.ftl               # Error page
│   └── resources/
│       ├── css/
│       │   └── login.css       # All login styles
│       └── js/
│           └── login.js        # Login interactions
│
└── account/                     # Account theme
    ├── theme.properties        # Account config
    ├── template.ftl            # Account layout
    ├── account.ftl             # Account page
    └── resources/
        ├── css/
        │   └── account.css     # Account styles
        └── js/
            └── account.js      # Account interactions
```

## Customization Cheat Sheet

### Change Primary Color

Edit CSS variables in `login/resources/css/login.css`:
```css
:root {
  --primary: #1E293B;      /* Change this */
  --secondary: #0EA5E9;
  /* ... */
}
```

### Add Your Logo

1. Place logo image in `login/resources/img/`
2. Edit `login/template.ftl`:
   ```html
   <!-- Replace this -->
   <i class="bi bi-briefcase-fill"></i>
   
   <!-- With this -->
   <img src="${resourcesPath}/img/your-logo.png" alt="Logo">
   ```

### Change Font

1. Edit Google Fonts link in `template.ftl`:
   ```html
   <link href="https://fonts.googleapis.com/css2?family=YOUR+FONT:wght@400;600;700&display=swap">
   ```
2. Update CSS:
   ```css
   body {
     font-family: 'Your Font', sans-serif;
   }
   ```

### Customize Text

Edit message keys in `login/messages_en.properties`:
```properties
loginTitle=My Custom Title
doLogIn=Sign In
registerTitle=Create Account
```

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| **Theme not showing** | Restart Keycloak, check folder name is exactly `skillmarket` |
| **Styling broken** | Clear browser cache, check CDN accessibility |
| **Forms not working** | Check JavaScript is enabled, verify Bootstrap JS loading |
| **Mobile looks wrong** | Test in DevTools mobile mode, clear cache |
| **Can't find theme dropdown** | Make sure theme is in correct path and Keycloak restarted |

## Next Steps

1. **Customize**: See [README.md](README.md) for detailed customization guide
2. **Deploy**: See [INSTALLATION.md](INSTALLATION.md) for production setup
3. **Configure**: Add email theme, admin console theme (optional)
4. **Test**: Try all forms (login, register, password reset)

## Performance Tips

```bash
# Enable theme caching
-Dkeycloak.staticMaxAge=2592000

# Preload critical resources
# Edit template.ftl to add preload links
<link rel="preload" href="${resourcesPath}/css/login.css" as="style">
```

## Troubleshooting Commands

```bash
# Check theme location
ls -la $KEYCLOAK_HOME/themes/skillmarket/

# Check permissions
stat $KEYCLOAK_HOME/themes/skillmarket/

# View Keycloak logs
tail -f $KEYCLOAK_HOME/standalone/log/server.log

# Docker logs
docker logs -f keycloak

# Verify CDN access
curl -I https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css
```

## Default Credentials (If Applicable)

- **Keycloak Admin URL**: http://localhost:8080/admin
- **Admin Username**: admin
- **Admin Password**: admin (or your configured password)

⚠️ **Security Note**: Change default admin password in production!

## Support

- Full docs: See [README.md](README.md)
- Installation help: See [INSTALLATION.md](INSTALLATION.md)
- Keycloak docs: https://www.keycloak.org/documentation

## License

Part of the SkillMarket project. Free to use and modify.

---

**Enjoy your new SkillMarket Keycloak theme! 🎨**

Need help? Check the full documentation files or Keycloak community forums.
