<#import "template.ftl" as layout>
<@layout.registrationLayout title=msg("doLogIn")>
    <div class="kc-panel-head">
        <h1 class="kc-page-title">Enter password</h1>
        <p class="kc-page-subtitle">Confirm your password to continue.</p>
    </div>

    <div class="kc-login-container">
        <div class="kc-login-card">
            <form id="kc-form-login" class="kc-form-login" action="${url.loginAction}" method="post">
                <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if> />

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
                    <input id="username" class="form-control" name="username" value="${(login.username!'')}" type="text" readonly />
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">${msg("password")}</label>
                    <input id="password" class="form-control <#if messagesPerField.existsError('password')>is-invalid</#if>" name="password" type="password" autocomplete="current-password" autofocus />
                    <#if messagesPerField.existsError('password')>
                        <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</div>
                    </#if>
                </div>

                <button type="submit" class="btn btn-primary w-100" name="login" id="kc-login">
                    ${msg("doLogIn")}
                </button>
            </form>
        </div>
    </div>
</@layout.registrationLayout>