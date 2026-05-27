<#import "template.ftl" as layout>
<@layout.registrationLayout title=msg("doLogIn")>
    <div class="kc-panel-head">
        <h1 class="kc-page-title">Sign in</h1>
        <p class="kc-page-subtitle">Use your SkillMarket account to continue.</p>
    </div>

    <#assign usernameError = "">
    <#assign passwordError = "">
    <#if messagesPerField.existsError('username','password')>
        <#assign usernameError = messagesPerField.getFirstError('username','password')!"">
    </#if>

    <div class="kc-login-container">
        <div class="kc-login-card">
            <form id="kc-form-login" class="kc-form-login" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label for="username" class="form-label">
                        <#if !realm.loginWithEmailAllowed>
                            ${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>
                            ${msg("usernameOrEmail")}
                        <#else>
                            ${msg("email")}
                        </#if>
                    </label>
                    <input id="username" class="form-control <#if usernameError?has_content>is-invalid</#if>" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="username" />
                    <#if usernameError?has_content>
                        <div class="invalid-feedback d-block">${kcSanitize(usernameError)?no_esc}</div>
                    </#if>
                </div>

                <div class="form-group">
                    <div class="kc-inline-row">
                        <label for="password" class="form-label">${msg("password")}</label>
                        <#if realm.password && realm.resetPasswordAllowed>
                            <a href="${url.loginResetCredentialsUrl}" class="kc-link">${msg("doForgotPassword")}</a>
                        </#if>
                    </div>
                    <input id="password" class="form-control <#if usernameError?has_content>is-invalid</#if>" name="password" type="password" autocomplete="current-password" />
                </div>

                <#if realm.rememberMe && !usernameEditDisabled??>
                    <label class="form-check" for="rememberMe">
                        <input class="form-check-input" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if> />
                        <span class="form-check-label">${msg("rememberMe")}</span>
                    </label>
                </#if>

                <button type="submit" class="btn btn-primary w-100" name="login" id="kc-login">
                    ${msg("doLogIn")}
                </button>
            </form>

            <#if social.providers?? && social.providers?size gt 0>
                <div class="kc-divider"><span>${msg("or")}</span></div>
                <div class="kc-stack">
                    <#list social.providers as provider>
                        <a href="${provider.loginUrl}" class="btn btn-secondary w-100">${provider.displayName}</a>
                    </#list>
                </div>
            </#if>

            <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
                <p class="kc-meta">${msg("noAccount")} <a href="${url.registrationUrl}" class="kc-link">${msg("doRegister")}</a></p>
            </#if>
        </div>
    </div>
</@layout.registrationLayout>