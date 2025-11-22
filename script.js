/* script.js */
function navigateTo(url) {
  // Efek klik sederhana sebelum pindah
  setTimeout(() => {
    window.location.href = url;
  }, 100);
}

// Helper untuk back button
function goBack() {
  window.history.back();
}
