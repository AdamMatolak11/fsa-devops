<#import "template.ftl" as layout>
<@layout.registrationLayout title=msg("doRegister")>
    <div class="kc-panel-head">
        <h1 class="kc-page-title">Create account</h1>
        <p class="kc-page-subtitle">Join SkillMarket and complete your profile later.</p>
    </div>

    <div class="kc-login-container">
        <div class="kc-login-card">
            <form id="kc-register-form" class="kc-form-login" action="${url.registrationAction}" method="post">
                <div class="kc-form-grid">
                    <div class="form-group">
                        <label for="firstName" class="form-label">${msg("firstName")}</label>
                        <input id="firstName" class="form-control <#if messagesPerField.existsError('firstName')>is-invalid</#if>" name="firstName" type="text" value="${(register.formData.firstName!'')}" autocomplete="given-name" />
                        <#if messagesPerField.existsError('firstName')>
                            <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</div>
                        </#if>
                    </div>

                    <div class="form-group">
                        <label for="lastName" class="form-label">${msg("lastName")}</label>
                        <input id="lastName" class="form-control <#if messagesPerField.existsError('lastName')>is-invalid</#if>" name="lastName" type="text" value="${(register.formData.lastName!'')}" autocomplete="family-name" />
                        <#if messagesPerField.existsError('lastName')>
                            <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</div>
                        </#if>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">${msg("email")}</label>
                    <input id="email" class="form-control <#if messagesPerField.existsError('email')>is-invalid</#if>" name="email" type="email" value="${(register.formData.email!'')}" autocomplete="email" />
                    <#if messagesPerField.existsError('email')>
                        <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</div>
                    </#if>
                </div>

                <#if !realm.registrationEmailAsUsername>
                    <div class="form-group">
                        <label for="username" class="form-label">${msg("username")}</label>
                        <input id="username" class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>" name="username" type="text" value="${(register.formData.username!'')}" autocomplete="username" />
                        <#if messagesPerField.existsError('username')>
                            <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</div>
                        </#if>
                    </div>
                </#if>

                <div class="form-group">
                    <label for="userRole" class="form-label">Role</label>
                    <select id="userRole" class="form-control <#if messagesPerField.existsError('user.attributes.userRole')>is-invalid</#if>" name="user.attributes.userRole" required>
                        <option value="">Select your role</option>
                        <option value="CLIENT" <#if (register.formData['user.attributes.userRole']!'') == 'CLIENT'>selected</#if>>Client</option>
                        <option value="FREELANCER" <#if (register.formData['user.attributes.userRole']!'') == 'FREELANCER'>selected</#if>>Freelancer</option>
                    </select>                    <#if messagesPerField.existsError('user.attributes.userRole')>
                        <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('user.attributes.userRole'))?no_esc}</div>
                    </#if>
                </div>

                <div class="kc-form-grid">
                    <div class="form-group">
                        <label for="password" class="form-label">${msg("password")}</label>
                        <input id="password" class="form-control <#if messagesPerField.existsError('password')>is-invalid</#if>" name="password" type="password" autocomplete="new-password" />
                        <#if messagesPerField.existsError('password')>
                            <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</div>
                        </#if>
                    </div>

                    <div class="form-group">
                        <label for="password-confirm" class="form-label">${msg("passwordConfirm")}</label>
                        <input id="password-confirm" class="form-control <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>" name="password-confirm" type="password" autocomplete="new-password" />
                        <#if messagesPerField.existsError('password-confirm')>
                            <div class="invalid-feedback d-block">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</div>
                        </#if>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100">${msg("doRegister")}</button>
            </form>

            <p class="kc-meta"><a href="${url.loginUrl}" class="kc-link">Login</a></p>
        </div>
    </div>
</@layout.registrationLayout>