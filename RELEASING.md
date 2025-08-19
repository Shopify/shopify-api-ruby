# Releasing ShopifyAPI

## Prerequisites

Before starting a release, ensure you have:

- Merged all code change PRs into main

## Release Process

### Step 1: Prepare the Release Branch

1. **Ensure all feature changes are merged**

   ```bash
   git checkout main
   git pull origin main
   ```

   Verify: Latest commits should match GitHub's main branch.

2. **Review changes to determine version bump**
   - Review merged PRs since last release: `git log v14.11.1..HEAD --oneline`
   - Apply [semantic versioning](https://semver.org/):
     - PATCH (X.Y.Z+1): Bug fixes only
     - MINOR (X.Y+1.0): New features, backward compatible
     - MAJOR (X+1.0.0): Breaking changes

### Step 2: Create Release Pull Request

1. **Create a new branch**

   ```bash
   git checkout -b vX.Y.Z
   ```

2. **Update version number**
   Edit `lib/shopify_api/version.rb`:

   ```ruby
   module ShopifyAPI
     VERSION = "X.Y.Z"  # Replace with your version
   end
   ```

3. **Update dependencies**

   ```bash
   bundle update sorbet sorbet-runtime sorbet-static tapioca --conservative
   bundle install
   ```

   Expected: Gemfile.lock updates with new dependency versions.

4. **Update CHANGELOG**
   - Add entry under "## Unreleased" with format:

     ```markdown
     ## X.Y.Z (YYYY-MM-DD)
     
     - [#PR_NUMBER](https://github.com/Shopify/shopify-api-ruby/pull/PR_NUMBER) Description of change
     ```

   - Move all unreleased items under the new version

5. **Create and push PR**

   ```bash
   git add -A
   git commit -m "preparing for release v X.Y.Z"
   git push origin release-X.Y.Z
   ```

   - Title PR: "Release vX.Y.Z"
   - Add release notes to PR description

### Step 3: Tag and Publish

1. **After PR is merged, update local main**

   ```bash
   git checkout main
   git pull origin main
   ```

   Verify: `git log -1` shows your merge commit.

2. **Create and push tag**

   ```bash
   git tag -f vX.Y.Z && git push origin vX.Y.Z
   ```

   Verify: Tag appears at [https://github.com/Shopify/shopify-api-ruby/tags](https://github.com/Shopify/shopify-api-ruby/tags)

3. **Publish via Shipit**

4. **Verify gem publication**

   List the gem on [https://rubygems.org/gems/shopify_api](https://rubygems.org/gems/shopify_api/versions/)

   Expected: Shows your new version (may take 5-10 minutes).

### Step 4: Update Dependent Projects (Optional)

For major/minor releases, update these repositories:
  
- **Shopify/shopify_app**: Update gemspec
  - File: `shopify_app.gemspec`
  - Priority: High for breaking changes, medium otherwise
