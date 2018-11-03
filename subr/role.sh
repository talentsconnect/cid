### role.sh -- Support for roles, users, groups and policies

# El Cid (https://github.com/michipili/cid)
# This file is part of El Cid
#
# Copyright © 2018 Michael Grünewald
#
# This file must be used under the terms of the MIT license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution. The terms
# are also available at
# https://opensource.org/licenses/MIT

# We start with a simple model, where:
#
# - There is a finite list of possible roles. (admin, developer, anonymous)
# - Each role is attached to a hardwired policy-document.


# role_user_db NAME
#  Print the user database for environment NAME
#
# The user database has the following columns:
#
#  USERNAME | DISPLAYNAME | ROLE

role_user_db()
{
    cat <<EOF
root|Charlie Root|admin
EOF
}


# role_user_secret USERNAME
#  Print the secret associated to USERNAME

role_user_secret()
{
    case "$1" in
        root)
            printf 'CaitVuelpUrreyftUryoyWishyhuft'
            ;;
        *)
            wlog 'Error' '%s: User does not exist.' "$1"
            exit 70
            ;;
    esac
}

### End of file `role.sh'
