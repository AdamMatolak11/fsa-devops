<#import "template.ftl" as layout>

<@layout.mainLayout active='account' pageTitle="${msg('editAccountTitle')}">
    <div class="kc-account-page">
        <div class="container-lg py-4">
            <div class="row">
                <div class="col-lg-3 mb-4 mb-lg-0">
                    <!-- Account Sidebar Navigation -->
                    <div class="kc-account-sidebar">
                        <nav class="list-group">
                            <a href="${url.accountUrl}" class="list-group-item list-group-item-action active" aria-current="true">
                                <i class="bi bi-person me-2"></i> My Account
                            </a>
                            <a href="${url.changePasswordUrl}" class="list-group-item list-group-item-action">
                                <i class="bi bi-lock me-2"></i> Change Password
                            </a>
                            <a href="${url.authenticatorUrl}" class="list-group-item list-group-item-action">
                                <i class="bi bi-shield-check me-2"></i> Authenticator
                            </a>
                            <a href="${url.sessionsUrl}" class="list-group-item list-group-item-action">
                                <i class="bi bi-terminal me-2"></i> Sessions
                            </a>
                            <a href="${url.applicationsUrl}" class="list-group-item list-group-item-action">
                                <i class="bi bi-app-indicator me-2"></i> Connected Apps
                            </a>
                        </nav>
                    </div>
                </div>

                <div class="col-lg-9">
                    <!-- Main Account Content -->
                    <div class="kc-account-content">
                        <div class="kc-account-card">
                            <div class="kc-account-header">
                                <h1><i class="bi bi-person-circle me-2"></i> Edit Account</h1>
                                <p class="text-muted">Update your personal information</p>
                            </div>

                            <#if message?has_content>
                                <div class="alert alert-info alert-dismissible fade show" role="alert">
                                    ${message.summary?no_esc}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </#if>

                            <form id="kc-form-profile" class="kc-form-account" action="${url.accountUrl}" method="post">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="user.firstName" class="form-label">First Name</label>
                                            <input type="text" id="user.firstName" class="form-control" name="user.firstName" value="${(account.firstName!'')}" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group mb-3">
                                            <label for="user.lastName" class="form-label">Last Name</label>
                                            <input type="text" id="user.lastName" class="form-control" name="user.lastName" value="${(account.lastName!'')}" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="user.email" class="form-label">Email</label>
                                    <input type="email" id="user.email" class="form-control" name="user.email" value="${(account.email!'')}" />
                                </div>

                                <#if realm.editUsernameAllowed>
                                    <div class="form-group mb-4">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" id="username" class="form-control" name="username" value="${(account.username!'')}" disabled />
                                        <small class="text-muted">Username cannot be changed</small>
                                    </div>
                                </#if>

                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i> Save Changes
                                    </button>
                                    <a href="${url.homeUrl}" class="btn btn-outline-secondary ms-2">
                                        <i class="bi bi-x-circle me-2"></i> Cancel
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layout.mainLayout>
