class VerifyDocs
  def self.call
    readme_content = File.read("README.md").lines[2..-1]
    docs_content = File.read("docs/index.md").lines[4..-1]
    readme_content == docs_content
  end
end
