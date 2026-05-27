<#macro registrationLayout title="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title!msg("loginTitle", realm.displayName)}</title>
    <link href="${url.resourcesPath}/css/login.css" rel="stylesheet">
</head>
<body class="kc-login-page">
    <div class="kc-login-shell">
        <section class="kc-login-panel">
            <header class="kc-header">
                <div class="kc-brand">
                    <span class="kc-brand-mark" aria-hidden="true">
                        <span class="kc-brand-mark-bar kc-brand-mark-bar-primary"></span>
                        <span class="kc-brand-mark-bar kc-brand-mark-bar-secondary"></span>
                    </span>
                    <div class="kc-brand-copy">
                        <span class="kc-brand-name">SkillMarket</span>
                        <span class="kc-brand-tag">Freelance marketplace</span>
                    </div>
                </div>
            </header>

            <main class="kc-main-content">
                <#if message?has_content>
                    <div class="alert <#if message.type == 'success'>alert-success<#elseif message.type == 'warning'>alert-warning<#elseif message.type == 'error'>alert-danger<#else>alert-info</#if>" role="alert">
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <#nested>
            </main>
        </section>

        <aside class="kc-aside">
            <div class="kc-aside-inner">
                <p class="kc-eyebrow">SkillMarket</p>
                <h1 class="kc-aside-title">Projects, offers and delivery in one calmer flow.</h1>
                <p class="kc-aside-text">
                    Sign in to review work, manage project progress and keep client and freelancer collaboration visible.
                </p>
                <div class="kc-aside-grid">
                    <div class="kc-aside-card">
                        <strong>Offers</strong>
                        <span>Review scope and budget before work starts.</span>
                    </div>
                    <div class="kc-aside-card">
                        <strong>Tasks</strong>
                        <span>Track progress from open work to review.</span>
                    </div>
                    <div class="kc-aside-card">
                        <strong>Ratings</strong>
                        <span>Close projects with a clear shared history.</span>
                    </div>
                    <div class="kc-aside-card">
                        <strong>Profiles</strong>
                        <span>Work with people you can evaluate quickly.</span>
                    </div>
                </div>
            </div>
        </aside>
    </div>
</body>
</html>
</#macro>