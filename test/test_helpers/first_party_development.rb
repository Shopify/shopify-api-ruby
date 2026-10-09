# typed: false
# frozen_string_literal: true

module TestHelpers
  module FirstPartyDevelopment
    def with_dev_server(core, enabled: true)
      previous_dev_server = if Object.const_defined?(:DevServer)
        Object.const_get(:DevServer) # rubocop:disable Sorbet/ConstantsFromStrings
      end
      previous_using_dev = ENV["USING_DEV"]
      Object.send(:remove_const, :DevServer) if previous_dev_server
      dev_server = mock("DevServer")
      dev_server.stubs(:core).returns(core)
      Object.const_set(:DevServer, dev_server)
      enabled ? ENV["USING_DEV"] = "1" : ENV.delete("USING_DEV")
      yield dev_server
    ensure
      Object.send(:remove_const, :DevServer)
      Object.const_set(:DevServer, previous_dev_server) if previous_dev_server
      previous_using_dev ? ENV["USING_DEV"] = previous_using_dev : ENV.delete("USING_DEV")
    end
  end
end
