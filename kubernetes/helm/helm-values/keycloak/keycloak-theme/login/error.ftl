<#import "template.ftl" as layout>
<@layout.registrationLayout title=msg("errorTitle")>
    <div class="kc-panel-head">
        <h1 class="kc-page-title">${msg("errorTitle")}</h1>
        <p class="kc-page-subtitle">The requested page could not be displayed.</p>
    </div>

    <div class="kc-login-container">
        <div class="kc-login-card">
            <#if message?has_content>
                <div class="alert alert-danger" role="alert">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                    <#if message.detail?has_content>
                        <p class="kc-error-detail">${kcSanitize(message.detail)?no_esc}</p>
                    </#if>
                </div>
            </#if>

            <#if client?? && client.baseUrl?has_content>
                <a href="${client.baseUrl}" class="btn btn-primary w-100">${msg("backToApplication")}</a>
            <#else>
                <a href="${url.loginUrl}" class="btn btn-primary w-100">${msg("backToLogin")!"Back to login"}</a>
            </#if>

            <#if requiredActions?has_content>
                <div class="alert alert-info" role="alert">
                    <strong>${msg("requiredActions")!"Required actions"}</strong>
                    <ul class="kc-list">
                        <#list requiredActions as action>
                            <li>${action}</li>
                        </#list>
                    </ul>
                </div>
            </#if>
        </div>
    </div>
</@layout.registrationLayout>