# Adding a New API Version to Shopify API Ruby

## Overview
This guide provides step-by-step instructions for adding a new API version to the Shopify API Ruby library. This example uses the addition of the 2025-07 API version as a reference, but the process applies to any new API version.

## Prerequisites
- Understanding of any breaking changes or removed resources in the new API version

## Step 1: Update API Version Constants

### Update admin_versions.rb
Edit `lib/shopify_api/admin_versions.rb` to add your new version:

```ruby
module ShopifyAPI
  module AdminVersions
    SUPPORTED_ADMIN_VERSIONS = T.let([
      "unstable",
      "2025-10",  # Add new version here
      "2025-07",
      "2025-04",
      # ... other versions
    ], T::Array[String])

    LATEST_SUPPORTED_ADMIN_VERSION = T.let("2025-07", String)  # Update if this is the latest stable
    RELEASE_CANDIDATE_ADMIN_VERSION = T.let("2025-10", String)  # Update if this is RC
  end
end
```

**Version Management:**
- Add new versions to the top of `SUPPORTED_ADMIN_VERSIONS`
- Update `LATEST_SUPPORTED_ADMIN_VERSION` when the version is stable
- Update `RELEASE_CANDIDATE_ADMIN_VERSION` for release candidates

## Step 2: Create Directory Structure

### Create Resource Directory
```bash
mkdir lib/shopify_api/rest/resources/{YYYY_MM}/
```
Example: `lib/shopify_api/rest/resources/2025_07/`

### Create Test Directory
```bash
mkdir test/rest/{YYYY_MM}/
```
Example: `test/rest/2025_07/`

**Directory Naming Convention:**
- Format: `YYYY_MM` (e.g., `2025_04`, `2025_07`, `2025_10`)
- Use underscore between year and month

## Step 3: Copy Resource Files from Previous Version

### Copy All Resource Files
```bash
# Copy resource files
cp -r lib/shopify_api/rest/resources/{PREVIOUS_VERSION}/* lib/shopify_api/rest/resources/{NEW_VERSION}/

# Copy test files
cp -r test/rest/{PREVIOUS_VERSION}/* test/rest/{NEW_VERSION}/
```

Example:
```bash
cp -r lib/shopify_api/rest/resources/2025_04/* lib/shopify_api/rest/resources/2025_07/
cp -r test/rest/2025_04/* test/rest/2025_07/
```

## Step 4: Update Test Files

After copying test files, you must update version-specific information in each test file.

### Update Test Class Names
Change the class name to include the new version:

```ruby
# From
class AbandonedCheckout202504Test < Test::Unit::TestCase

# To
class AbandonedCheckout202507Test < Test::Unit::TestCase
```

**Naming Pattern:** `{ResourceName}{YYYYMM}Test`
- Remove underscores from the version (e.g., `202507` not `2025_07`)

### Update Context API Version
In the `setup` method, update the API version:

```ruby
def setup
  super
  test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
  ShopifyAPI::Context.activate_session(test_session)
  
  # Update this line:
  modify_context(api_version: "2025-07")  # Was "2025-04"
end
```

### Update URLs in Stub Requests
Update all API URLs in the test methods:

```ruby
# From
stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-04/checkouts.json")

# To
stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-07/checkouts.json")
```

## Step 5: Handle Breaking Changes

### Identify Removed Resources
In this example, `CustomerAddress` was removed in 2025-07.

### Remove Deprecated Resources
If a resource is removed:
```bash
# Remove resource file
rm lib/shopify_api/rest/resources/{NEW_VERSION}/{resource_name}.rb

# Remove test file
rm test/rest/{NEW_VERSION}/{resource_name}_test.rb
```

### Update Modified Resources
If a resource has structural changes:
1. Update the resource class attributes
2. Modify the `@paths` array if endpoints changed
3. Update method signatures if parameters changed
4. Adjust test cases accordingly

## Step 7: Run Tests

### Execute Test Suite
```bash
# Run all tests
bundle exec rake test

# Run specific version tests
bundle exec rake test TEST=test/rest/{NEW_VERSION}/*
```

## Checklist

- [ ] Added new version to `SUPPORTED_ADMIN_VERSIONS` in `admin_versions.rb`
- [ ] Updated `LATEST_SUPPORTED_ADMIN_VERSION` if applicable
- [ ] Updated `RELEASE_CANDIDATE_ADMIN_VERSION` if applicable
- [ ] Created `lib/shopify_api/rest/resources/{NEW_VERSION}/` directory
- [ ] Created `test/rest/{NEW_VERSION}/` directory
- [ ] Copied all resource files from previous version
- [ ] Copied all test files from previous version
- [ ] Updated test class names (e.g., `Article202507Test`)
- [ ] Updated API version in test contexts (`modify_context(api_version: "2025-07")`)
- [ ] Updated all API URLs in test stub requests
- [ ] Removed deprecated resources and their tests
- [ ] Updated any modified resources
- [ ] Run test suite successfully