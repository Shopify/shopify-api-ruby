# This script ensure the README is kept in sync with the docs published at http://shopify.github.io/shopify_api

readme_content = File.read("README.md").lines[2..-1].join
docs_content = File.read("docs/index.md").lines[4..-1].join

if readme_content == docs_content
  exit
else
  abort("README content doesn't match docs content, please update to keep in sync")
end
