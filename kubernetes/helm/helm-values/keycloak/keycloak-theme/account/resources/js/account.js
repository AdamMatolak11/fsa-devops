/* SkillMarket Keycloak Account Theme - JavaScript */

document.addEventListener('DOMContentLoaded', function() {
  // Close alerts after 5 seconds
  const alerts = document.querySelectorAll('.alert');
  alerts.forEach(alert => {
    const closeButton = alert.querySelector('.btn-close');
    if (closeButton) {
      setTimeout(() => {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, 5000);
    }
  });

  // Form validation
  const forms = document.querySelectorAll('.kc-form-account');
  forms.forEach(form => {
    form.addEventListener('submit', function() {
      const submitButton = form.querySelector('button[type="submit"]');
      if (submitButton) {
        submitButton.disabled = true;
        const originalText = submitButton.innerHTML;
        submitButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Saving...';
        
        // Re-enable button after 5 seconds if nothing happens
        setTimeout(() => {
          submitButton.disabled = false;
          submitButton.innerHTML = originalText;
        }, 5000);
      }
    });
  });

  // Add active class to current navigation item
  const currentUrl = window.location.href;
  document.querySelectorAll('.kc-account-sidebar .list-group-item').forEach(item => {
    if (item.href === currentUrl || currentUrl.includes(item.getAttribute('href'))) {
      item.classList.add('active');
    }
  });

  // Smooth transitions for sidebar items
  document.querySelectorAll('.kc-account-sidebar .list-group-item').forEach(item => {
    item.addEventListener('click', function(e) {
      document.querySelectorAll('.kc-account-sidebar .list-group-item').forEach(i => {
        i.classList.remove('active');
      });
      this.classList.add('active');
    });
  });
});

// Copy to clipboard function
function copyToClipboard(text) {
  navigator.clipboard.writeText(text).then(() => {
    // Show success message
    const alert = document.createElement('div');
    alert.className = 'alert alert-success alert-dismissible fade show';
    alert.innerHTML = `
      <i class="bi bi-check-circle me-2"></i>
      Copied to clipboard!
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    document.body.insertBefore(alert, document.body.firstChild);
    setTimeout(() => {
      alert.remove();
    }, 3000);
  });
}

// Confirm before action
function confirmAction(message) {
  return confirm(message);
}
