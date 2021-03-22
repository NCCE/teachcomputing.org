# To use this add a before hook stubbing the appropriate flag with a hash.
# Then unstub in an after hook e.g:

# before do
#   stub_feature_flags({ flag_key: true })
# end
#
# after do
#   unstub_feature_flags
# end

module FeatureFlagHelper
  def stub_feature_flags(flag_hash = {})
    dbl = instance_double(FeatureFlagService)
    allow(FeatureFlagService).to receive(:new) { dbl }
    allow(dbl).to receive(:flags).and_return(flag_hash)
  end

  def unstub_feature_flags
    allow(FeatureFlagService).to receive(:new).and_call_original
  end
end
