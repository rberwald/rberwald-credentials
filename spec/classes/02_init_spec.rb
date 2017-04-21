require 'spec_helper'

describe 'credentials' do
  describe 'Single user, single credential' do
    let (:params) {{
      :users => {
        'user1' => {
          'vault' => {
            'ensure' => 'file',
            'path' => 'filepath',
            'content' => 'some-content',
          }
        }
      }
    }}

    it { should contain_file('/home/user1/filepath').with( {
          'ensure'  => 'file',
          'content' => 'some-content',
          'owner'   => 'root',
          'group'   => 'user1',
          'mode'    => '0440',
        }
      )
    }
  end

  describe 'Single user, multiple credentials' do
    let (:params) {{
      :users => {
        'user1' => {
          'vault' => {
            'ensure' => 'file',
            'path' => 'filepath',
            'content' => 'some-content',
          },
          'safe' => {
            'ensure' => 'absent',
            'path' => 'filepath2',
          }
        }
      }
    }}

    it { should contain_file('/home/user1/filepath').with( {
          'ensure'  => 'file',
          'content' => 'some-content',
          'owner'   => 'root',
          'group'   => 'user1',
          'mode'    => '0440',
        }
      )
    }

    it { should contain_file('/home/user1/filepath2').with( {
          'ensure'  => 'absent',
        }
      )
    }
  end

  describe 'Multiple users, multiple credentials' do
    let (:params) {{
      :users => {
        'user1' => {
          'vault' => {
            'ensure' => 'file',
            'path' => 'filepath',
            'content' => 'some-content',
          },
          'safe' => {
            'ensure' => 'absent',
            'path' => 'filepath2',
          }
        },
        'user2' => {
          'vault' => {
            'ensure' => 'file',
            'path' => 'filepath',
            'content' => 'some-other-content',
          },
          'unsafe' => {
            'ensure' => 'file',
            'path' => 'filepath2',
            'content' => 'weird-content',
          }
        }
      }
    }}

    it { should contain_file('/home/user1/filepath').with( {
          'ensure'  => 'file',
          'content' => 'some-content',
          'owner'   => 'root',
          'group'   => 'user1',
          'mode'    => '0440',
        }
      )
    }

    it { should contain_file('/home/user1/filepath2').with( {
          'ensure'  => 'absent',
        }
      )
    }

    it { should contain_file('/home/user2/filepath').with( {
          'ensure'  => 'file',
          'content' => 'some-other-content',
          'owner'   => 'root',
          'group'   => 'user2',
          'mode'    => '0440',
        }
      )
    }

    it { should contain_file('/home/user2/filepath2').with( {
          'ensure'  => 'file',
          'content' => 'weird-content',
          'owner'   => 'root',
          'group'   => 'user2',
          'mode'    => '0440',
        }
      )
    }
  end
end
