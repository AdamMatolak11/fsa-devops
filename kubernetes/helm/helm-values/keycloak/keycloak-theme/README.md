# SkillMarket Keycloak Theme

A custom Keycloak theme built with FTL (Freemarker Template Language) and styled to match the SkillMarket app design. This theme provides a modern, responsive authentication interface with a professional dark slate color scheme and cyan accents.

## Theme Structure

```
keycloak-theme/
├── theme.properties                 # Root theme configuration
├── login/                           # Login theme
│   ├── theme.properties            # Login theme properties
│   ├── template.ftl                # Base layout template
│   ├── login.ftl                   # Login page
│   ├── register.ftl                # Registration page
│   └── resources/
│       ├── css/
│       │   └── login.css           # Login styles
│       └── js/
│           └── login.js            # Login interactions
└── account/                         # Account management theme
    ├── theme.properties            # Account theme properties
    ├── template.ftl                # Account base layout
    ├── account.ftl                 # Account management page
    └── resources/
        ├── css/
        │   └── account.css         # Account styles
        └── js/
            └── account.js          # Account interactions
```

## Design System

### Colors
- **Primary**: `#1E293B` (Dark Slate) - Used for headers and primary UI
- **Secondary**: `#0EA5E9` (Cyan/Sky Blue) - Used for accents and interactive elements
- **Success**: `#10B981` (Green) - Used for positive actions
- **Danger**: `#EF4444` (Red) - Used for destructive actions
- **Background**: `#F8FAFC` (Light) - Clean background color
- **Dark**: `#0F172A` (Almost Black) - Text and dark elements

### Typography
- **Font Family**: `Plus Jakarta Sans` (with system font fallbacks)
- **Font Weights**: 300 (light), 400 (regular), 500 (medium), 600 (semibold), 700 (bold)

### Design Elements
- **Border Radius**: 0.375rem to 1rem for smooth corners
- **Shadows**: Subtle shadows for depth and elevation
- **Transitions**: Smooth 0.3s transitions for interactive elements
- **Layout**: Bootstrap 5 grid system for responsive design

## Features

### Login Page
- ✅ Username/Email and password fields
- ✅ Social provider support
- ✅ Remember me checkbox
- ✅ Forgot password link
- ✅ Registration link
- ✅ Responsive design (mobile, tablet, desktop)
- ✅ Dark and light mode support
- ✅ Icon integration (Bootstrap Icons)
- ✅ Alert messages (success, warning, error, info)
- ✅ Form validation feedback
- ✅ Decorative side section

### Registration Page
- ✅ First and last name fields
- ✅ Email validation
- ✅ Username field (conditional)
- ✅ Password confirmation
- ✅ Error feedback for each field
- ✅ Link back to login
- ✅ Same responsive design as login

### Account Management
- ✅ Profile editing
- ✅ Password change
- ✅ Authenticator configuration
- ✅ Session management
- ✅ Connected applications
- ✅ Sidebar navigation
- ✅ Responsive layout

## Installation

### Prerequisites
- Keycloak 14+ (tested with 14.x, 15.x, 16.x, 17.x, 18.x)
- Keycloak running in standalone or containerized mode

### Steps

1. **Copy the theme folder to Keycloak**:
   ```bash
   # Standalone installation
   cp -r keycloak-theme $KEYCLOAK_HOME/themes/skillmarket
   
   # Docker container
   docker cp keycloak-theme <container-id>:/opt/keycloak/themes/skillmarket
   ```

2. **Restart Keycloak**:
   ```bash
   # Standalone
   $KEYCLOAK_HOME/bin/kc.sh start
   
   # Docker
   docker restart <container-id>
   ```

3. **Configure the theme in Keycloak Admin Console**:
   - Go to: Realm Settings → Themes
   - Set:
     - **Login Theme**: `skillmarket`
     - **Account Theme**: `skillmarket-account`
   - Click Save

4. **Verify**:
   - Go to your Keycloak login page
   - The new SkillMarket theme should be applied

## Customization

### Colors
Edit the `:root` CSS variables in the theme files:

**Login theme** (`login/resources/css/login.css`):
```css
:root {
  --primary: #1E293B;
  --secondary: #0EA5E9;
  /* ... */
}
```

**Account theme** (`account/resources/css/account.css`):
```css
:root {
  --primary: #1E293B;
  --secondary: #0EA5E9;
  /* ... */
}
```

### Logo
Replace the icon in the templates. Currently uses Bootstrap Icons:
```ftl
<i class="bi bi-briefcase-fill"></i>
```

To use a custom logo:
1. Add your logo image to `login/resources/img/`
2. Replace the icon element with:
   ```ftl
   <img src="${resourcesPath}/img/your-logo.svg" alt="Logo" class="logo">
   ```

### Fonts
The theme uses Google Fonts (Plus Jakarta Sans). To change:
1. Edit the font import in `template.ftl`:
   ```html
   <link href="https://fonts.googleapis.com/css2?family=YOUR+FONT:wght@300;400;500;600;700&display=swap" rel="stylesheet">
   ```
2. Update the font-family in CSS variables

### Text Messages
Keycloak uses message keys for internationalization. Common keys:
- `loginTitle` - Login page title
- `doLogIn` - Login button text
- `username` - Username field label
- `password` - Password field label
- `doRegister` - Register button text
- `registerTitle` - Registration page title

To customize messages:
1. Create or edit `login/messages_en.properties`:
   ```properties
   loginTitle=Welcome to SkillMarket
   doLogIn=Sign In
   ```

## Browser Support

- ✅ Chrome/Chromium (latest 2 versions)
- ✅ Firefox (latest 2 versions)
- ✅ Safari (latest 2 versions)
- ✅ Edge (latest 2 versions)
- ✅ Mobile browsers

## Accessibility

The theme includes:
- ✅ Semantic HTML structure
- ✅ ARIA labels for form fields
- ✅ Keyboard navigation support
- ✅ Focus indicators
- ✅ Color contrast compliance (WCAG AA)
- ✅ Responsive text sizing

## Security Notes

- All user inputs are properly escaped in FTL templates
- CSRF protection is handled by Keycloak
- No sensitive information is exposed in the templates
- External resources (CDN) are loaded securely (HTTPS)

## Troubleshooting

### Theme not showing up
1. Check theme folder name matches exactly: `skillmarket`
2. Restart Keycloak
3. Clear browser cache
4. Check Keycloak logs for errors

### Styling looks broken
1. Check browser console for CSS loading errors
2. Verify CDN URLs are accessible (Bootstrap, Bootstrap Icons, Google Fonts)
3. Check Keycloak theme configuration

### Form fields not responsive
1. Verify Bootstrap CSS is loading correctly
2. Check for console errors
3. Test in different browsers

## File Locations

- **Keycloak Standalone**: `$KEYCLOAK_HOME/themes/skillmarket/`
- **Docker Container**: `/opt/keycloak/themes/skillmarket/`
- **Docker Volumes**: Mount at `/opt/keycloak/themes`

## Performance

The theme is optimized for performance:
- Minimal external dependencies
- CDN-hosted libraries (Bootstrap, Icons, Fonts)
- CSS minification ready
- Lazy loading support
- No blocking JavaScript

## Updates

When updating Keycloak:
1. Verify theme compatibility with Keycloak release notes
2. Test the theme thoroughly before deploying to production
3. Keep external CDN URLs up to date

## License

This theme is part of the SkillMarket project. Use and modify as needed for your Keycloak instance.

## Support

For issues or questions:
1. Check Keycloak documentation: https://www.keycloak.org/documentation
2. Review FTL template syntax: https://freemarker.apache.org/
3. Check Bootstrap documentation: https://getbootstrap.com/

## Additional FTL Templates

This theme can be extended with additional templates:

- `login-password.ftl` - Password-only login form
- `password-reset.ftl` - Password reset page
- `update-password.ftl` - Update password on first login
- `error.ftl` - Error page
- `info.ftl` - Information page

To add these templates, create the `.ftl` files in the `login/` directory with appropriate content.

## Version History

- **v1.0.0** (2024) - Initial release
  - Login page with modern design
  - Registration page
  - Account management dashboard
  - Dark/Light mode support
  - Mobile responsive design
