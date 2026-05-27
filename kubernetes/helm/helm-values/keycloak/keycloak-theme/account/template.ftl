<#macro mainLayout active="" pageTitle="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><#if pageTitle>${pageTitle}<#else>Account - ${realm.displayName}</#if></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom Account Styles -->
    <link href="${url.resourcesPath}/css/account.css" rel="stylesheet">
</head>
<body class="kc-account-page-body">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container-lg">
            <a class="navbar-brand fw-bold" href="${url.homeUrl}">
                <i class="bi bi-briefcase-fill me-2"></i>
                ${realm.displayName}
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <button class="btn btn-link nav-link dropdown-toggle" id="userMenu" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle me-2"></i>
                            ${account.firstName!'User'}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
                            <li><a class="dropdown-item" href="${url.accountUrl}"><i class="bi bi-person me-2"></i>My Account</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${url.logoutUrl}"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="kc-account-main">
        <div class="kc-account-wrapper">
            <#nested>
        </div>
    </main>

    <!-- Footer -->
    <footer class="kc-account-footer bg-light border-top mt-5">
        <div class="container-lg py-4">
            <p class="text-center text-muted mb-0">
                &copy; ${.now?string('yyyy')} ${realm.displayName}. All rights reserved.
            </p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom Account Scripts -->
    <script src="${url.resourcesPath}/js/account.js"></script>
</body>
</html>
</#macro>
