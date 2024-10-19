[:documents, :pages].each do |hook|
  Jekyll::Hooks.register hook, :post_render do |item|
    content = item.output
    site_url = item.site.config['url']
    whitelist = [site_url, '/', 'localhost', 'mailto:', 'tel:']  # whitelist domains

    # Add target="_blank" to external links
    content.gsub!(%r{<a\s+href="((?!#{whitelist.map { |d| Regexp.escape(d) }.join('|')})[^"]+)"(?![^>]*rel=)},
            "<a href=\"\\1\" target=\"_blank\"")
    # Update the item content
    item.output = content
  end
end
