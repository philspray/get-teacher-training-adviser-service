# rubocop:disable Lint/PercentStringArray
SecureHeaders::Configuration.default do |config|
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w[origin-when-cross-origin strict-origin-when-cross-origin]

  google_analytcs = "https://www.google-analytics.com"

  config.csp = {
    default_src: %w['none'],
    base_uri: %w['self'],
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w['self' ct.pinterest.com tr.snapchat.com *.hotjar.com],
    connect_src: %W['self' #{google_analytcs} ct.pinterest.com *.hotjar.com],
    font_src: %w['self' *.gov.uk fonts.gstatic.com],
    form_action: %w['self' tr.snapchat.com],
    frame_ancestors: %w['none'],
    img_src: %W['self' *.gov.uk data: maps.gstatic.com *.googleapis.com #{google_analytcs} www.facebook.com ct.pinterest.com t.co],
    manifest_src: %w['self'],
    media_src: %w['self'],
    script_src: %W['self' 'unsafe-inline' *.googleapis.com *.gov.uk code.jquery.com #{google_analytcs} *.facebook.net *.googletagmanager.com *.hotjar.com *.pinimg.com sc-static.net static.ads-twitter.com analytics.twitter.com],
    style_src: %w['self' 'unsafe-inline' *.gov.uk *.googleapis.com],
    worker_src: %w['self'],
    upgrade_insecure_requests: true, # see https://www.w3.org/TR/upgrade-insecure-requests/
    report_uri: [ENV["SENTRY_CSP_REPORT_URI"]],
  }
end
# rubocop:enable Lint/PercentStringArray
