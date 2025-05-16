gh auth switch
email=$(gh api user --jq .email)
git config --local user.email $email
