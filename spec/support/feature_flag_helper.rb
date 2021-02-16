module FeatureFlagHelper
  def stub_feature_flags(flag_hash = {})
    dbl = double(FeatureFlagService)
    allow(FeatureFlagService).to receive(:new) { dbl }
    allow(dbl).to receive(:flags).and_return(flag_hash)
  end
end
