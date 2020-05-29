class VerifyDocs
  def self.call
    readme_content = File.read("README.md")
    docs_content = File.read("docs/index.md")
    require 'pry'; binding.pry
  end
end
