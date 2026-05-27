# Keycloak Theme Installation & Deployment Guide

This guide provides detailed instructions for deploying the SkillMarket custom Keycloak theme.

## Table of Contents

1. [Local Installation](#local-installation)
2. [Docker Installation](#docker-installation)
3. [Kubernetes Installation](#kubernetes-installation)
4. [Configuration](#configuration)
5. [Verification](#verification)
6. [Troubleshooting](#troubleshooting)

## Local Installation

### Prerequisites
- Keycloak 14+ installed and running
- File system access to Keycloak home directory
- Keycloak restart capability

### Steps

1. **Locate Keycloak Home Directory**:
   ```bash
   # Find your Keycloak installation
   export KEYCLOAK_HOME=/path/to/keycloak
   # or
   echo $KEYCLOAK_HOME
   ```

2. **Create Theme Directory**:
   ```bash
   mkdir -p $KEYCLOAK_HOME/themes/skillmarket
   ```

3. **Copy Theme Files**:
   ```bash
   cp -r keycloak-theme/* $KEYCLOAK_HOME/themes/skillmarket/
   ```

4. **Verify Directory Structure**:
   ```bash
   tree $KEYCLOAK_HOME/themes/skillmarket/
   # or
   find $KEYCLOAK_HOME/themes/skillmarket/ -type f
   ```

5. **Set Permissions** (if needed):
   ```bash
   chmod -R 755 $KEYCLOAK_HOME/themes/skillmarket/
   chown -R keycloak:keycloak $KEYCLOAK_HOME/themes/skillmarket/
   ```

6. **Restart Keycloak**:
   ```bash
   # Standalone
   $KEYCLOAK_HOME/bin/kc.sh start
   
   # Or if using standalone script
   $KEYCLOAK_HOME/bin/standalone.sh
   ```

## Docker Installation

### Method 1: Volume Mount

1. **Create Docker Volume**:
   ```bash
   docker volume create keycloak-themes
   ```

2. **Copy Theme to Volume**:
   ```bash
   # Copy theme files to the volume
   docker run -v keycloak-themes:/themes -v $(pwd)/keycloak-theme:/src \
     busybox cp -r /src/* /themes/
   ```

3. **Run Keycloak with Theme Volume**:
   ```bash
   docker run -d \
     --name keycloak \
     -v keycloak-themes:/opt/keycloak/themes \
     -p 8080:8080 \
     -e KEYCLOAK_ADMIN=admin \
     -e KEYCLOAK_ADMIN_PASSWORD=admin \
     quay.io/keycloak/keycloak:latest \
     start --optimized
   ```

### Method 2: Custom Dockerfile

1. **Create Dockerfile**:
   ```dockerfile
   FROM quay.io/keycloak/keycloak:latest
   
   COPY keycloak-theme/ /opt/keycloak/themes/skillmarket/
   
   RUN chmod -R 755 /opt/keycloak/themes/skillmarket/
   ```

2. **Build Image**:
   ```bash
   docker build -t keycloak-skillmarket:latest .
   ```

3. **Run Container**:
   ```bash
   docker run -d \
     --name keycloak \
     -p 8080:8080 \
     -e KEYCLOAK_ADMIN=admin \
     -e KEYCLOAK_ADMIN_PASSWORD=admin \
     keycloak-skillmarket:latest \
     start --optimized
   ```

### Method 3: Bind Mount

```bash
docker run -d \
  --name keycloak \
  -v $(pwd)/keycloak-theme:/opt/keycloak/themes/skillmarket \
  -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:latest \
  start --optimized
```

### Method 4: Docker Compose

```yaml
version: '3.8'

services:
  keycloak:
    image: quay.io/keycloak/keycloak:latest
    container_name: keycloak
    ports:
      - "8080:8080"
    environment:
      KEYCLOAK_ADMIN: admin
      KEYCLOAK_ADMIN_PASSWORD: admin
    volumes:
      - ./keycloak-theme:/opt/keycloak/themes/skillmarket
    command: start --optimized
    networks:
      - keycloak-network

networks:
  keycloak-network:
    driver: bridge
```

Run with:
```bash
docker-compose up -d
```

## Kubernetes Installation

### Using ConfigMap

1. **Create ConfigMap from theme files**:
   ```bash
   kubectl create configmap keycloak-theme \
     --from-file=keycloak-theme/ \
     -n keycloak
   ```

2. **Create Keycloak Deployment** (`keycloak-deploy.yaml`):
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: keycloak
     namespace: keycloak
   spec:
     replicas: 1
     selector:
       matchLabels:
         app: keycloak
     template:
       metadata:
         labels:
           app: keycloak
       spec:
         containers:
         - name: keycloak
           image: quay.io/keycloak/keycloak:latest
           ports:
           - containerPort: 8080
           env:
           - name: KEYCLOAK_ADMIN
             value: "admin"
           - name: KEYCLOAK_ADMIN_PASSWORD
             valueFrom:
               secretKeyRef:
                 name: keycloak-admin
                 key: password
           volumeMounts:
           - name: theme-volume
             mountPath: /opt/keycloak/themes/skillmarket
           args:
           - start
           - --optimized
         volumes:
         - name: theme-volume
           configMap:
             name: keycloak-theme
   ```

3. **Apply Configuration**:
   ```bash
   kubectl apply -f keycloak-deploy.yaml
   ```

### Using Persistent Volume

1. **Create PVC**:
   ```bash
   kubectl apply -f - <<EOF
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: keycloak-themes
     namespace: keycloak
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
   EOF
   ```

2. **Copy theme to PVC**:
   ```bash
   kubectl cp keycloak-theme/ keycloak/keycloak-pod:/opt/keycloak/themes/skillmarket
   ```

## Configuration

### Access Keycloak Admin Console

1. **URL**: `http://localhost:8080/admin`
2. **Default Credentials**:
   - Username: `admin`
   - Password: `admin` (or your configured password)

### Configure Theme for Realm

1. **Navigate to Realm Settings**:
   - Click on your realm name (dropdown top-left)
   - Select "Realm Settings"
   - Go to "Themes" tab

2. **Set Theme**:
   - **Login Theme**: Select `skillmarket`
   - **Account Theme**: Select `skillmarket-account`
   - **Email Theme**: (optional) Select `skillmarket`
   - **Admin Theme**: (optional) Leave as default or customize

3. **Apply Settings**:
   - Click "Save"
   - Refresh the page or logout to see changes

### Configure Theme Properties

Edit `theme.properties` files to customize:

**Main theme** (`theme.properties`):
```properties
parent=base
import=common/keycloak
```

**Login theme** (`login/theme.properties`):
```properties
parent=base
import=common/keycloak
styles=css/login.css
```

## Verification

### Test Login Page

1. **Access Login**:
   - Go to: `http://localhost:8080/realms/master/account/`
   - You should be redirected to login page
   - Verify SkillMarket theme is applied

2. **Check Elements**:
   - ✅ Logo displays correctly
   - ✅ Colors match theme (dark slate primary, cyan secondary)
   - ✅ Form fields are styled
   - ✅ Buttons are functional
   - ✅ Responsive design works on mobile

### Browser Developer Tools

Check console for:
- No CSS loading errors
- No JavaScript errors
- All resources load successfully

```javascript
// In browser console
document.styleSheets.forEach(sheet => console.log(sheet.href));
```

### Check Theme Files

```bash
# Verify theme structure
ls -la $KEYCLOAK_HOME/themes/skillmarket/
ls -la $KEYCLOAK_HOME/themes/skillmarket/login/
ls -la $KEYCLOAK_HOME/themes/skillmarket/account/
```

## Troubleshooting

### Theme Not Showing Up

**Problem**: Theme doesn't appear in Realm Settings dropdown

**Solutions**:
1. Verify theme folder name is exactly `skillmarket`
2. Check file permissions:
   ```bash
   chmod -R 755 $KEYCLOAK_HOME/themes/skillmarket/
   ```
3. Restart Keycloak completely
4. Clear browser cache
5. Check Keycloak logs for errors

### Styling Looks Broken

**Problem**: CSS not loading, colors wrong, layout broken

**Solutions**:
1. Check browser DevTools > Network tab
2. Verify CDN URLs are accessible:
   - Bootstrap: `cdn.jsdelivr.net`
   - Bootstrap Icons: `cdn.jsdelivr.net`
   - Google Fonts: `fonts.googleapis.com`
3. Check for console errors
4. Try different browser (Chrome, Firefox, Safari)
5. Clear cache: `Ctrl+Shift+Del` or equivalent

### Forms Not Responsive

**Problem**: Forms not responding to clicks, buttons not working

**Solutions**:
1. Check JavaScript is enabled in browser
2. Verify Bootstrap JS is loading in Network tab
3. Check console for JavaScript errors
4. Try in incognito/private mode

### CDN Issues

**Problem**: External resources not loading (fonts, icons, bootstrap)

**Solutions**:
1. Check internet connection
2. Verify CDN is not blocked by firewall
3. Update CDN URLs in templates
4. Host resources locally instead:

```bash
# Download Bootstrap CSS
curl -o $KEYCLOAK_HOME/themes/skillmarket/login/resources/css/bootstrap.min.css \
  https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css
```

Then update template reference:
```html
<link href="${resourcesPath}/css/bootstrap.min.css" rel="stylesheet">
```

### Docker-Specific Issues

**Problem**: Theme not visible in Docker container

**Solutions**:
1. Verify volume mount:
   ```bash
   docker exec keycloak ls -la /opt/keycloak/themes/skillmarket/
   ```
2. Check file permissions in container:
   ```bash
   docker exec keycloak chmod -R 755 /opt/keycloak/themes/skillmarket/
   ```
3. Restart container:
   ```bash
   docker restart keycloak
   ```

### Check Keycloak Logs

```bash
# Standalone
tail -f $KEYCLOAK_HOME/standalone/log/server.log

# Docker
docker logs -f keycloak

# Kubernetes
kubectl logs -f deployment/keycloak -n keycloak
```

### Database Issues

If theme settings not persisting:
1. Check database connectivity
2. Verify Keycloak can write to database
3. Restart Keycloak and reapply settings

### Multi-Realm Setup

If using multiple realms, configure theme for each:
1. Select realm in dropdown
2. Go to Realm Settings > Themes
3. Apply theme settings for that realm

## Performance Optimization

### Enable Caching

```bash
# In standalone.xml or via environment variables
-Dkeycloak.staticMaxAge=2592000
```

### Minify CSS/JS

For production, minify resources:
```bash
# CSS
csso $KEYCLOAK_HOME/themes/skillmarket/login/resources/css/login.css -o login.min.css

# JavaScript
uglifyjs $KEYCLOAK_HOME/themes/skillmarket/login/resources/js/login.js -o login.min.js
```

### Use Local CDN Cache

Consider self-hosting CDN resources for better performance:
```bash
# Download resources
cd $KEYCLOAK_HOME/themes/skillmarket/login/resources/
mkdir -p vendor
# Download Bootstrap, Bootstrap Icons, Google Fonts...
```

## Production Deployment Checklist

- [ ] Theme files copied to correct location
- [ ] File permissions set correctly
- [ ] Theme appears in Realm Settings
- [ ] Applied to desired realms
- [ ] Login page tested
- [ ] Registration page tested
- [ ] Account page tested
- [ ] Mobile responsiveness verified
- [ ] All external resources accessible
- [ ] Error handling tested
- [ ] Performance acceptable
- [ ] Security review completed
- [ ] Backup of Keycloak theme directory created
- [ ] Documentation updated

## Rollback Procedure

If issues arise:

1. **Disable Theme**:
   - Go to Realm Settings > Themes
   - Set Login Theme back to `keycloak`
   - Click Save

2. **Remove Theme**:
   ```bash
   rm -rf $KEYCLOAK_HOME/themes/skillmarket/
   ```

3. **Restart Keycloak**:
   ```bash
   $KEYCLOAK_HOME/bin/kc.sh start
   ```

## Support & Additional Resources

- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [FTL Template Guide](https://freemarker.apache.org/)
- [Bootstrap Documentation](https://getbootstrap.com/)
- [Bootstrap Icons](https://icons.getbootstrap.com/)

## Version Compatibility

| Keycloak Version | Status |
|-----------------|--------|
| 14.x | ✅ Tested |
| 15.x | ✅ Tested |
| 16.x | ✅ Tested |
| 17.x | ✅ Tested |
| 18.x | ✅ Tested |
| 19.x | ⚠️ Not tested |
| 20.x | ⚠️ Not tested |

For newer versions, test thoroughly before production deployment.
