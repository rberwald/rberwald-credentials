# Class: credentials
# ===========================
#
# Class to create files that contain credentials for users
# Files are protected again accidental snooping by setting
# the owner to 'root' and teh group to the group of the user.
#
# For the security part, the implementation assumes that
# every user has its own personal group.
#
# Parameters
# ----------
#
# @param users User hash with all the information
#
# Examples
# --------
#
# credentials::users:
#   rbe:
#     vault:
#       ensure: 'file'
#       path: '.vault-token'
#       content: '12345678-abcd-5432-1a2b-fedbca09876'
#   user1:
#     vault:
#       ensure : 'file'
#       path: '.vault-token'
#       content: 'xxxxxxxx-aaaa-bbbb-cccc-yyyyyyyy'
#
class credentials (
  Hash    $users,
) {

  $users.each | String $user, Hash $user_creds | {
    $user_creds.each | String $cred, Hash $cred_attr | {
      file { "/home/${user}/${cred_attr['path']}":
        ensure  => $cred_attr['ensure'],
        content => $cred_attr['content'],
        owner   => 'root',
        group   => $user,
        # Mode prevents user from changing the file accidently
        # and the world from snooping
        mode    => '0440',
      }
    }
  }

}
