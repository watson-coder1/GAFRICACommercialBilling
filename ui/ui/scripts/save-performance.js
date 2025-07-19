/**
 * Save Performance Enhancement Script
 * Provides immediate feedback for save operations
 */

// Add loading indicators to all forms
$(document).ready(function() {
    // Add loading indicator styles if not present
    if (!$('#loading-styles').length) {
        $('head').append(`
            <style id="loading-styles">
                .btn-loading {
                    position: relative;
                    pointer-events: none;
                    opacity: 0.7;
                }
                .btn-loading::after {
                    content: "";
                    position: absolute;
                    width: 16px;
                    height: 16px;
                    margin: auto;
                    border: 2px solid transparent;
                    border-top-color: #ffffff;
                    border-radius: 50%;
                    animation: button-loading-spinner 1s ease infinite;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                }
                @keyframes button-loading-spinner {
                    from { transform: translate(-50%, -50%) rotate(0turn); }
                    to { transform: translate(-50%, -50%) rotate(1turn); }
                }
                .form-saving {
                    opacity: 0.8;
                    pointer-events: none;
                }
            </style>
        `);
    }

    // Enhance form submissions with immediate feedback
    $('form').on('submit', function(e) {
        var $form = $(this);
        var $submitBtn = $form.find('button[type="submit"], input[type="submit"]');
        
        // Don't add loading if already processing
        if ($submitBtn.hasClass('btn-loading')) {
            return false;
        }
        
        // Add loading state
        $submitBtn.addClass('btn-loading');
        $submitBtn.data('original-text', $submitBtn.text());
        $submitBtn.text('Saving...');
        $form.addClass('form-saving');
        
        // Auto-remove loading state after 15 seconds (fallback)
        setTimeout(function() {
            $submitBtn.removeClass('btn-loading');
            $submitBtn.text($submitBtn.data('original-text') || 'Save');
            $form.removeClass('form-saving');
        }, 15000);
    });

    // Add debouncing to input validation
    var validationTimeout;
    $('input[name="username"], input[name="ip_address"]').on('input', function() {
        var $input = $(this);
        clearTimeout(validationTimeout);
        
        validationTimeout = setTimeout(function() {
            // Existing validation logic
            if (typeof checkValidation === 'function') {
                checkValidation();
            }
        }, 500); // 500ms debounce for validation
    });

    // Optimize AJAX calls with abort functionality
    var currentAjaxRequests = {};
    
    // Override jQuery AJAX to track requests
    var originalAjax = $.ajax;
    $.ajax = function(options) {
        var requestKey = options.url + (options.data || '');
        
        // Abort previous request to same endpoint
        if (currentAjaxRequests[requestKey]) {
            currentAjaxRequests[requestKey].abort();
        }
        
        // Add timeout if not specified
        if (!options.timeout) {
            options.timeout = 10000; // 10 second default
        }
        
        var xhr = originalAjax.call(this, options);
        currentAjaxRequests[requestKey] = xhr;
        
        // Clean up completed requests
        xhr.always(function() {
            delete currentAjaxRequests[requestKey];
        });
        
        return xhr;
    };
});

// Success notification helper
function showSaveSuccess(message) {
    if (typeof Swal !== 'undefined') {
        Swal.fire({
            title: 'Success!',
            text: message || 'Data saved successfully',
            icon: 'success',
            timer: 2000,
            showConfirmButton: false
        });
    } else {
        alert(message || 'Data saved successfully');
    }
}

// Error notification helper
function showSaveError(message) {
    if (typeof Swal !== 'undefined') {
        Swal.fire({
            title: 'Error!',
            text: message || 'An error occurred while saving',
            icon: 'error',
            confirmButtonText: 'OK'
        });
    } else {
        alert(message || 'An error occurred while saving');
    }
}