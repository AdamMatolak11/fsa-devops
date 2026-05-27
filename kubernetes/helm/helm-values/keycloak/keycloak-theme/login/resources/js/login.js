/* SkillMarket Keycloak Login Theme - JavaScript */

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

  // Form validation feedback
  const forms = document.querySelectorAll('.kc-form-login, .kc-form-register');
  forms.forEach(form => {
    form.addEventListener('submit', function() {
      // Disable submit button to prevent duplicate submissions
      const submitButton = form.querySelector('button[type="submit"]');
      if (submitButton) {
        submitButton.disabled = true;
        submitButton.innerHTML = '<span class="kc-loading"></span> Processing...';
      }
    });
  });

  // Focus management for better accessibility
  const firstInput = document.querySelector('.form-control');
  if (firstInput) {
    setTimeout(() => {
      firstInput.focus();
    }, 100);
  }

  // Password visibility toggle (optional)
  const passwordInputs = document.querySelectorAll('input[type="password"]');
  passwordInputs.forEach(input => {
    input.addEventListener('keydown', function(e) {
      // Show password on Ctrl+Shift+P
      if (e.ctrlKey && e.shiftKey && e.key === 'P') {
        this.type = this.type === 'password' ? 'text' : 'password';
        e.preventDefault();
      }
    });
  });

  // Smooth scroll on anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth' });
      }
    });
  });
});

// Prevent XSS attacks
function sanitizeHTML(html) {
  const div = document.createElement('div');
  div.textContent = html;
  return div.innerHTML;
}
