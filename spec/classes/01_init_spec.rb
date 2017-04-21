require 'spec_helper'

describe 'credentials' do
  describe 'credentials' do
    let (:params) {{
      :users => {},
    }}

    it { should compile.with_all_deps }

    it { should contain_class('credentials') }

  end

end
